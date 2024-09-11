FactoryBot.define do
  factory :user do
    name { 'Miguel' }
    last_name { 'Rodriguez' }
    sequence(:email) { |n| "miguel#{n}@mail.com" }
    sequence(:phone) { |n| "3109209#{n}" }
    gender { "male" }
  end
end
