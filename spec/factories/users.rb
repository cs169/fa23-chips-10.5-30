FactoryBot.define do
  factory :user do
    # sequence(:username) { |n| "user#{n}" }
    email { 'test@gmail.com' }
    # password { 'password' }
    # password_confirmation { 'password' }
    provider { 1 }
    uid { '123' }

    trait :admin do
      role { 'admin' }
    end
  end
end
