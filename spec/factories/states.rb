# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'New York' }
    symbol { 'NY' }
    fips_code { 'Test Fips' }
    is_territory { false }
    lat_min { '1' }
    lat_max { '2' }
    long_min { '3' }
    long_max { '4' }
  end
end
