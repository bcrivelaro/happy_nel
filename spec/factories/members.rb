FactoryBot.define do
  factory :member do
    name { 'name' }
    sequence(:email) { |n| "member#{n}@email.com" }
    admin
  end
end
