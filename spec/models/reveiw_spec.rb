require "rails_helper"

describe Review do

  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
    it {should validate_presence_of(:rating)}
  end

  describe "relationships" do
    it {should belong_to(:book)}
    it {should belong_to(:user)}
  end

  before :each do
    @user_1 = User.create!(name: "User 1")
    @user_2 = User.create!(name: "User 2")
    @user_3 = User.create!(name: "User 3")
    @user_4 = User.create!(name: "User 4")
    @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155)
    @book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245)
    @book_3 = Book.create!(title: 'Book 3', published: 1965, pages: 245)
    @book_4 = Book.create!(title: 'Book 4', published: 1965, pages: 245)
    @review_1 = Review.create!(title: 'Review 1', rating: 1, body: 'content 1', book: @book_1, user: @user_1)
    @review_2 = Review.create!(title: 'Review 2', rating: 2, body: 'content 2', book: @book_2, user: @user_2)
    @review_3 = Review.create!(title: 'Review 3', rating: 3, body: 'content 3', book: @book_3, user: @user_3)
    @review_4 = Review.create!(title: 'Review 4', rating: 4, body: 'content 3', book: @book_1, user: @user_4)
    @review_5 = Review.create!(title: 'Review 4', rating: 5, body: 'content 3', book: @book_4, user: @user_4)
    @review_6 = Review.create!(title: 'Review 5', rating: 5, body: 'content 3', book: @book_4, user: @user_1)
    @review_7 = Review.create!(title: 'Review 6', rating: 5, body: 'content 3', book: @book_3, user: @user_2)
  end

  describe 'instance methods' do

    it '.find_book' do
      expect(@review_1.find_book).to eq(@book_1)
    end

  end

  describe 'class methods' do

    it '.top_three' do
      expect(Review.top_three.length).to eq(3)
      expect(Review.top_three).to include(@review_5)
      expect(Review.top_three).to include(@review_6)
      expect(Review.top_three).to include(@review_7)
    end

    it '.bottom_three' do
      expect(Review.bottom_three.length).to eq(3)
      expect(Review.bottom_three).to include(@review_1)
      expect(Review.bottom_three).to include(@review_2)
      expect(Review.bottom_three).to include(@review_3)
    end

    it '.average_rating' do
      expect(Review.average_rating.to_f.round(2)).to eq(3.57)
    end

    it '.find_user_reviews' do
      expect(Review.find_user_reviews(@user_1).length).to eq(2)
      expect(Review.find_user_reviews(@user_1)).to include(@review_1)
      expect(Review.find_user_reviews(@user_1)).to include(@review_6)
    end

  end

end
