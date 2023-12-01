# frozen_string_literal: true

class CandidateController < ApplicationController
  def search
    return unless valid_params?

    fetch_candidate_data
  end

  private

  def valid_params?
    params[:cycle].present? && params[:category].present?
  end

  def fetch_candidate_data
    cycle = params[:cycle]
    category = params[:category]
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"

    output = fetch_data_from_api(url)

    handle_response(output)
  end

  def fetch_data_from_api(url)
    Faraday.get(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-API-Key'] = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
    end
  end

  def handle_response(output)
    Rails.logger.info("Request URL: #{output.env.url}")
    Rails.logger.info("Response: #{output.body}")

    begin
      response_data = JSON.parse(output.body)
      render_results(response_data)
    rescue JSON::ParserError => e
      Rails.logger.error("Error parsing JSON: #{e.message}")
      handle_error
    end
  end

  def render_results(response_data)
    @candidates = Candidate.propublica_to_candidates(response_data)
    @cycle = params[:cycle]
    @category = params[:category]
    render 'candidate/results'
  end

  def handle_error
    @error_message = response.body['message']
    flash[:alert] = 'Error fetching from API. Try again'
    render 'candidate/search'
  end
end
