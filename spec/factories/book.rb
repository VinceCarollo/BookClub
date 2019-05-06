FactoryBot.define do
  factory :book do
    title { "Slade House" }
    author
    pages { 168 }
    published { 2016 }
  end
end
