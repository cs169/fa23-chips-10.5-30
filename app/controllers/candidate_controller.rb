# frozen_string_literal: true

class CandidateController < ApplicationController
  def search
    @election_cycles = %w[2010 2012 2014 2016 2018 2020]
    @financial_categories = %w[candidate-loan contribution-total debts-owed disbursements-total end-cash
                               individual-total pac-total receipts-total refund-total]
    if params[:cycle] && params[:category]
      cycle = params[:cycle]
      category = params[:category]
      url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
      output = Faraday.get(url) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-API-Key'] = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
      end
      Rails.logger.info("Request URL: #{url}")
      Rails.logger.info("Response: #{output.body}")
      begin
        response_data = JSON.parse(output.body)
      rescue JSON::ParserError => e
        Rails.logger.error("Error parsing JSON: #{e.message}")
      end
      if response_data.nil?
        # If the request is not successful, handle the error
        @error_message = response.body['message']
        flash[:alert] = 'Error fetching from API. Try again'
        render 'candidate/search'
      else
        # If the request is successful, call the model function
        @candidates = Candidate.propublica_to_candidates(response_data)
        @cycle = cycle
        @category = category
        render 'candidate/results'
      end
    end
  end
end
