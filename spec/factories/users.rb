# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name      "Jim"
    sequence(:email) {|n| "email#{n}@factory.com" }
    password  "secret"
    password_confirmation "secret"
  end
end
