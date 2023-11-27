# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Sample News' }
    representative_id { '' }
    created_at { '' }
    updated_at { '' }
    link { '' }

    # Associations
    association :representative, factory: :representative
  end
end
