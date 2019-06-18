require "rails_helper"

describe "when I make a review" do

    before :each do
      @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @author_1 = Author.create!(name: 'Author 1')
      BookAuthor.create!(book: @book_1, author: @author_1)
      @user_1 = User.create!(name: "User 1")
      @review_1 = Review.create!(title: 'Review 1', rating: 2, body: 'content 1', book: @book_1, user: @user_1)
    end

  it "creates a new review" do
    visit book_reviews_new_path(@book_1)
    fill_in :review_username, with: "tom Jones"
    fill_in :review_rating, with: 5
    fill_in :review_body, with: "A bookly book"
    fill_in :review_title, with: "Booking good"
    click_on "Create Review"
    expect(current_path).to eq(book_path(@book_1))
    within("#review-#{Review.last.id}")  do
      expect(page).to have_content("Tom Jones")
      expect(page).to have_content("Rating: 5")
      expect(page).to have_content("A bookly book")
      expect(page).to have_content("Booking good")
    end
  end

    it "doesnt_error on no review rating" do
      visit book_reviews_new_path(@book_1)
      fill_in :review_username, with: "tom Jones"
      fill_in :review_rating, with: nil
      fill_in :review_body, with: "A bookly book"
      fill_in :review_title, with: "Booking good"
      click_on "Create Review"
      expect(current_path).to eq(book_reviews_new_path(@book_1))
      expect(Review.last).to eq(@review_1)
    end
  end
