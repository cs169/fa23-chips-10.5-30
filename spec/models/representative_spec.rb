# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) { instance_double(rep_info) }

    before do
      allow(rep_info).to receive(:officials).and_return([instance_double(official, name: 'Stone Werner', party: 'Democrat',
address: 'Los Angeles', photo_url: '')])
      allow(rep_info).to receive(:offices).and_return([instance_double(office1, name: 'Mayor', division_id: 'ocdid1',
official_indices: [0])])
    end

    it 'no matching name, creates new rep' do
      existing_rep = described_class.create(name: 'Emma Holt', ocdid: 'ocdid1', title: 'Governator')

      reps = described_class.civic_api_to_representative_params(rep_info)

      expect(reps.size).to eq(1)
      expect(reps.first).not_to eq(existing_rep)
    end

    it 'finds rep, doesnt create new one' do
      # Create a representative with the same Name to simulate an existing record
      existing_rep = described_class.create(name: 'Stone Werner', ocdid: 'ocdid1', title: 'Governator')

      reps = described_class.civic_api_to_representative_params(rep_info)

      # should not have created a new rep becuase Arnold already has ocdid1
      expect(reps.size).to eq(1)
      expect(reps.first).to eq(existing_rep)
    end
  end
end
