require "rails_helper"

describe User do

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "relationships" do
    it {should have_many(:reviews)}
  end

  it ".review_count" do
    user_1 = User.create!(name: "User 1")
    user_2 = User.create!(name: "User 2")
    book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155)
    book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245)
    review_1 = Review.create!(title: 'Review 1', rating: 2, body: 'content 1', book: book_1, user: user_1)
    review_2 = Review.create!(title: 'Review 2', rating: 3, body: 'content 2', book: book_2, user: user_1)
    review_3 = Review.create!(title: 'Review 3', rating: 4, body: 'content 3', book: book_1, user: user_2)

      expect(user_1.review_count).to eq(2)
      expect(user_2.review_count).to eq(1)
  end


end
