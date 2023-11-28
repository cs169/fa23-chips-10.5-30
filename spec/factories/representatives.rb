# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'John Doe' }
    ocdid { 'ocdid123' }
    title { 'Congressman' }
    # Add other representative attributes as needed
  end
end
