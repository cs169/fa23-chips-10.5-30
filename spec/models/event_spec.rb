# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Event do
  describe 'validates start and end time' do
    it 'is valid if start time is after today and end time after start time' do
      @county = County.create # Save the county to the database
      @event = described_class.new(county: @county, start_time: Time.zone.local(2024, 11, 24),
                                   end_time: Time.zone.local(2024, 12, 1))
      expect(@event).to be_valid
    end
  end
end
