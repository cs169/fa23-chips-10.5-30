# spec/models/representative_spec.rb

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) { double('rep_info') }

    it 'creates or finds representatives based on ocdid' do
      allow(rep_info).to receive(:officials).and_return([
        double('official', name: 'Stone Werner'),
        # can add more officials here
      ])

      allow(rep_info).to receive(:offices).and_return([
        double('office1', name: 'Mayor', division_id: 'ocdid1', official_indices: [0]),
        # can add more officials here
      ])

      # Create a representative with the same ocdid to simulate an existing record
      existing_rep = Representative.create(name: 'Arnold', ocdid: 'ocdid1', title: 'Governator')

      reps = Representative.civic_api_to_representative_params(rep_info)

      #should not have created a new rep becuase Arnold already has ocdid1
      expect(reps.size).to eq(1)
      expect(reps.first).to eq(existing_rep)
    end
  end
end
