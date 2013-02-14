# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commission_membership do
    position "MyString"
    commission_id 1
    deputy_id 1
  end
end
