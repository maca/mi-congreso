# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :initiative do
    title "MyString"
    member_id 1
    description "MyText"
    subject_id 1
    original_document_url "MyString"
    presented_at "2012-10-04 20:36:16"
  end
end
