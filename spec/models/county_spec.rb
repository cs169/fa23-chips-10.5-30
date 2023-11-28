# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe County do
  describe '#std_fips_code' do
    it 'returns a standardized FIPS code' do
      county = described_class.new(fips_code: 1)
      expect(county.std_fips_code).to eq('001')
    end
  end
end
