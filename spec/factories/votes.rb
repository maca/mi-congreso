# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    value         1
    initiative_id 1
    voter_id      1
    voter_type    "Deputy"
  end
end
