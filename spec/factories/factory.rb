FactoryBot.define do
  sequence(:title) { |n| "Title #{n}" }
  sequence(:pages) { |n| (n + 200) * 4 }
  sequence(:published) { |n| n + 1977}

  factory :book do
    title
    pages
    published
  end

  factory :author do
    sequence(:name) { |n| "Author #{n}" }
  end

  factory :book_author do
    author
    book
  end
end
