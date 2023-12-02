# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidate do
  describe '.propublica_to_candidates' do
    it 'returns an array of candidate names from the ProPublica response' do
      propublica_response = {
        'results' => [
          { 'name' => 'Sinead McCaffery' },
          { 'name' => 'Emma Holt' },
          { 'name' => 'Stone Werner' }
        ]
      }
      result = Candidate.propublica_to_candidates(propublica_response)
      expect(result).to be_an(Array)
      expect(result).to eq(['Sinead McCaffery', 'Emma Holt', 'Stone Werner'])
    end

    it 'handles empty ProPublica response' do
      # Empty ProPublica response
      propublica_response = { 'results' => [] }
      result = Candidate.propublica_to_candidates(propublica_response)
      expect(result).to be_an(Array)
      expect(result).to be_empty
    end

    it 'handles nil ProPublica response' do
      # Nil ProPublica response
      propublica_response = nil
      result = Candidate.propublica_to_candidates(propublica_response)
      expect(result).to be_an(Array)
      expect(result).to be_empty
    end
  end
end
