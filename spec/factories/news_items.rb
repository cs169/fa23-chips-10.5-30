# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Sample News' }
    representative_id { '' }
    issue { 'Free Speech' }
    created_at { '' }
    updated_at { '' }
    link { '' }
    id { '123' }

    # Associations
    association :representative, factory: :representative
  end
end
