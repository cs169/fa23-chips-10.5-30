# frozen_string_literal: true

class Candidate < ApplicationRecord
  def self.propublica_to_candidates(response)
    list_of_candidates = response['results']
    names = []
    list_of_candidates.each do |candidate|
      names.push(candidate['name'])
    end
    names
  end
end
