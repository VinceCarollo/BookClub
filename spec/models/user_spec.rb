require "rails_helper"

describe User do

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:role)}
  end

  describe "relationships" do
    it {should have_many(:reviews)}
  end

  describe 'instance methods' do

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

  describe 'class methods' do

    it '.three_ratingest_users' do
      user_1 = User.create!(name: "User 1")
      user_2 = User.create!(name: "User 2")
      user_3 = User.create!(name: "User 3")
      user_4 = User.create!(name: "User 4")
      book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155)
      book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245)
      book_3 = Book.create!(title: 'Book 3', published: 1965, pages: 245)
      book_4 = Book.create!(title: 'Book 4', published: 1965, pages: 245)
      review_1 = Review.create!(title: 'Review 1', rating: 2, body: 'content 1', book: book_1, user: user_1)
      review_2 = Review.create!(title: 'Review 2', rating: 3, body: 'content 2', book: book_2, user: user_2)
      review_3 = Review.create!(title: 'Review 3', rating: 4, body: 'content 3', book: book_3, user: user_3)
      review_4 = Review.create!(title: 'Review 4', rating: 4, body: 'content 3', book: book_1, user: user_4)
      review_5 = Review.create!(title: 'Review 4', rating: 4, body: 'content 3', book: book_4, user: user_4)
      review_6 = Review.create!(title: 'Review 5', rating: 4, body: 'content 3', book: book_4, user: user_1)
      review_7 = Review.create!(title: 'Review 6', rating: 4, body: 'content 3', book: book_3, user: user_2)

      expect(User.three_ratingest_users.length).to eq(3)
      expect(User.three_ratingest_users).to include(user_1)
      expect(User.three_ratingest_users).to include(user_2)
      expect(User.three_ratingest_users).to include(user_4)
    end

  end


end
