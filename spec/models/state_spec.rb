# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe State do
  describe '#std_fips_code' do
    it 'returns a standardized FIPS code' do
      state = described_class.new(fips_code: 6)
      expect(state.std_fips_code).to eq('06')
    end
  end
end
