# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Sample Event' }
    description { 'This is a sample event' }
    start_time { Time.zone.now }
    end_time { Time.zone.now + 1.hour }
    county_id { '' }
    association :county, factory: :county
  end
end
