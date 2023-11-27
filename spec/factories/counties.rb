# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Sample County' }
    fips_code { 123 }
    state_id { '' }
    fips_class { '' }
    association :state, factory: :state
  end
end
