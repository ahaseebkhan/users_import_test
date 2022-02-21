FactoryBot.define do
  factory :user do
    sequence(:name) { Faker::Name.name }
    password { 'Helloworld123' }
  end
end
