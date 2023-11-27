# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    begin
      address = params[:address]
      service = Google::Apis::CivicinfoV2::CivicInfoService.new
      service.key = Rails.application.credentials[:GOOGLE_API_KEY]
      result = service.representative_info_by_address(address: address)
      
      # original
      @representatives = Representative.civic_api_to_representative_params(result)
      render 'representatives/search'
    rescue Google::Apis::Error => e
      # Log or handle the API error
      puts "Google Civic API Error: #{e.message}"
      flash[:alert] = "Error fetching representative information. Please try again later."
      render 'representatives/index'
    end
  end
end
