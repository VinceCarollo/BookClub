FactoryBot.define do


  factory :book do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:pages) { |n| (n + 200) * 4 }
    sequence(:published) { |n| n + 1977}

  end

  factory :author do
    sequence(:name) { |n| "Author #{n}" }
  end

  factory :book_author do
    author
    book
  end

  factory :user do
    sequence(:name) { |n| "Name #{n}" }
  end

  factory :review do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:body) { |n| "Content #{n}" }
    sequence(:rating) { |n| (n % 5) + 1 }
    book
    user
  end



end
