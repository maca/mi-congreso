# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :initiative_step do
    step 1
    start "2013-02-21"
    chamber "MyString"
  end
end
