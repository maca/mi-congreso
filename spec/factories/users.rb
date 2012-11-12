# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name      "Jim"
    email     "jim@google.com"
    password  "secret"
    password_confirmation "secret"
  end
end
