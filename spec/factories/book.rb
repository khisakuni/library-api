FactoryGirl.define do
  factory :book do
    author { Faker::Book.title }
    title { Faker::Book.author }
  end
end
