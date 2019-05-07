FactoryBot.define do
  factory :book do
    title { "Slade House" }
    pages { 168 }
    published { 2016 }
  end

  factory :author do
    name { "jon" }
  end

  factory :book_author do
    author
    book
  end
end
