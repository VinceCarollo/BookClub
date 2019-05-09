require "rails_helper"

describe Book do

  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:published)}
    it {should validate_presence_of(:pages)}
  end

  describe 'relationships' do
    it {should have_many(:book_authors)}
    it {should have_many(:reviews)}
    it {should have_many(:authors).through(:book_authors)}
  end

  before :each do
    @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155)
    @book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245)
    @book_3 = Book.create!(title: 'Book 3', published: 1975, pages: 33)
    @author_1 = Author.create!(name: 'Author 1')
    @author_2 = Author.create!(name: 'Author 2')
    @author_3 = Author.create!(name: 'Author 3')
    BookAuthor.create!(book: @book_1, author: @author_1)
    BookAuthor.create!(book: @book_1, author: @author_2)
    BookAuthor.create!(book: @book_2, author: @author_2)
    BookAuthor.create!(book: @book_3, author: @author_3)
    @user_1 = User.create!(name: "User 1")
    @user_2 = User.create!(name: "User 2")
    @user_3 = User.create!(name: "User 3")
    @user_4 = User.create!(name: "User 4")
    @review_1 = Review.create!(title: 'Review 1', rating: 2, body: 'content 1', book: @book_1, user: @user_1)
    @review_2 = Review.create!(title: 'Review 2', rating: 3, body: 'content 2', book: @book_1, user: @user_2)
    @review_3 = Review.create!(title: 'Review 3', rating: 4, body: 'content 3', book: @book_1, user: @user_3)
    @review_4 = Review.create!(title: 'Review 4', rating: 5, body: 'content 4', book: @book_2, user: @user_1)
    @review_5 = Review.create!(title: 'Review 5', rating: 2, body: 'content 5', book: @book_2, user: @user_2)
    @review_6 = Review.create!(title: 'Review 6', rating: 3, body: 'content 6', book: @book_2, user: @user_3)
    @review_7 = Review.create!(title: 'Review 7', rating: 1, body: 'content 7', book: @book_3, user: @user_3)
  end

  describe 'class methods' do

    it '.page_sort_asc' do
      sorted_books = Book.page_sort_asc

      expect(sorted_books[0]).to eq(@book_3)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_2)
    end

    it '.page_sort_desc' do
      sorted_books = Book.page_sort_desc

      expect(sorted_books[0]).to eq(@book_2)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_3)
    end

    it '.published_sort_asc' do
      sorted_books = Book.published_sort_asc

      expect(sorted_books[0]).to eq(@book_2)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_3)
    end

    it '.published_sort_desc' do
      sorted_books = Book.published_sort_desc

      expect(sorted_books[0]).to eq(@book_3)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_2)
    end

    it '.reviews_sort_asc' do
      sorted_books = Book.reviews_sort_asc

      expect(sorted_books[0]).to eq(@book_3)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_2)
    end

    it '.reviews_sort_desc' do
      sorted_books = Book.reviews_sort_desc

      expect(sorted_books[0]).to eq(@book_2)
      expect(sorted_books[1]).to eq(@book_1)
      expect(sorted_books[2]).to eq(@book_3)
    end

    # Review averages for each Book
    # "Book 1"
    # 3.0
    # "Book 2"
    # 3.33
    # "Book 3"
    # 1.0
    # "Book 4"
    # 4.0
    # "Book 5"
    # 5.0

    it '.highest_3_rated_titles' do
      book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
      book_5 = Book.create!(title: 'Book 5', published: 1955, pages: 478)
      review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 7', book: book_4, user: @user_3)
      review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 7', book: book_5, user: @user_4)

      highest_3 = Book.highest_3_rated_titles

      expect(highest_3[0]).to eq(book_5)
      expect(highest_3[1]).to eq(book_4)
      expect(highest_3[2]).to eq(@book_2)
    end

    it '.lowest_3_rated_titles' do
      book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
      book_5 = Book.create!(title: 'Book 5', published: 1955, pages: 478)
      review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 8', book: book_4, user: @user_3)
      review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 9', book: book_5, user: @user_4)

      lowest_3 = Book.lowest_3_rated_titles

      expect(lowest_3[0]).to eq(@book_3)
      expect(lowest_3[1]).to eq(@book_1)
      expect(lowest_3[2]).to eq(@book_2)
    end

  end

  describe 'instance methods' do

    it '#review_count' do
      book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
      review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 8', book: book_4, user: @user_3)
      review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 9', book: book_4, user: @user_4)
      review_9 = Review.create!(title: 'Review 10', rating: 5, body: 'content 10', book: book_4, user: @user_1)

      expect(book_4.review_count).to eq(3)
    end

    it '#review_average' do
      book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
      review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 8', book: book_4, user: @user_3)
      review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 9', book: book_4, user: @user_4)
      review_9 = Review.create!(title: 'Review 10', rating: 1, body: 'content 10', book: book_4, user: @user_1)

      expect(book_4.review_average.round(2)).to eq(3.33)
    end

  end

end
