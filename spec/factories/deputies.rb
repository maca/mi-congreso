# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deputy do
    name "MyString"
    email "MyString"
    party_id 1
    comission "MyString"
    state_id 1
    election_type "MyString"
    birthplace "MyString"
    birthdate "2012-09-11 18:23:58"
    substitute "MyString"
    education "MyText"
    political_experience "MyText"
    private_experience "MyText"
  end
end
