# frozen_string_literal: true
require 'rails_helper'
require 'spec_helper'

describe Representative do 
  describe '.civic_api_to_representative_params' do
    it 'creates representatives from Civic API data' do
      representative = instance_double('Representative')
      rep_info = double('rep_info')
      allow(rep_info).to receive(:officials).and_return([representative])

      office = double('office', name: 'Office Name', division_id: '123')

      # Set up expectations for the offices method
      allow(rep_info).to receive(:offices).and_return([office])

      # Set up expectations for the official_indices method
      allow(office).to receive(:official_indices).and_return([0])

      # Set up expectations for the name method on the official double
      allow(representative).to receive(:name).and_return('John Doe')

      # Set up expectations for the division_id method on the office double
      allow(office).to receive(:division_id).and_return('456')

      # Set up expectations for the create! method
      expect(Representative).to receive(:create!).with(
        name: 'John Doe',
        ocdid: '456', # Using the division_id from the office double
        title: 'Office Name'
      ).and_return(representative)
      result = Representative.civic_api_to_representative_params(rep_info)
 
      expect(result).to contain_exactly(representative)
    end
  end
end