# spec/models/representative_spec.rb

require 'rails_helper'

RSpec.describe Representative do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new(
        officials: [
          OpenStruct.new(name: 'John Doe', party: 'Democrat', address: '123 Main St', photo_url: 'http://example.com/john_doe.jpg'),
          OpenStruct.new(name: 'Jane Smith', party: 'Republican', address: '456 Oak St', photo_url: 'http://example.com/jane_smith.jpg')
        ],
        offices: [
          OpenStruct.new(name: 'Mayor', division_id: 'ocd-division/country:us/state:ny/city:new_york'),
          OpenStruct.new(name: 'Governor', division_id: 'ocd-division/country:us/state:ny')
        ]
      )
    end

    it 'creates representatives from Civic API response' do
      representatives = Representative.civic_api_to_representative_params(rep_info)
      expect(representatives).to be_an(Array)
      expect(representatives.size).to eq(2)

      expect(representatives[0].name).to eq('John Doe')
      expect(representatives[0].ocdid).to eq('ocd-division/country:us/state:ny/city:new_york')
      expect(representatives[0].title).to eq('Mayor')
      expect(representatives[0].political_party).to eq('Democrat')
      expect(representatives[0].address).to eq('123 Main St')
      expect(representatives[0].photo).to eq('http://example.com/john_doe.jpg')

      expect(representatives[1].name).to eq('Jane Smith')
      expect(representatives[1].ocdid).to eq('ocd-division/country:us/state:ny')
      expect(representatives[1].title).to eq('Governor')
      expect(representatives[1].political_party).to eq('Republican')
      expect(representatives[1].address).to eq('456 Oak St')
      expect(representatives[1].photo).to eq('http://example.com/jane_smith.jpg')
    end

    it 'does not create duplicate representatives with the same name' do
      # Create a representative with the same name as the first official
      existing_representative = create(:representative, name: 'John Doe')
      representatives = Representative.civic_api_to_representative_params(rep_info)
      expect(representatives).to be_an(Array)
      expect(representatives.size).to eq(2)
      expect(representatives[0]).to eq(existing_representative)
    end
  end
end



