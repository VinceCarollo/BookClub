require 'rails_helper'


RSpec.describe 'When a visitor goes to a books show page' do

  before :each do
    @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155)
    @book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245)
    @book_3 = Book.create!(title: 'Book 3', published: 1975, pages: 33)
    @book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
    @book_5 = Book.create!(title: 'Book 5', published: 1955, pages: 478)
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
    @review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 7', book: @book_4, user: @user_3)
    @review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 7', book: @book_5, user: @user_4)
  end


  it 'shows all of that books attributes' do
    visit book_path(@book_1)

    expect(page).to have_content(@book_1.title)

    @book_1.authors.each do |author|
      expect(page).to have_content(author.name)
    end

    expect(page).to have_content(@book_1.pages)
  end

  it 'shows all of that books reviews' do
    visit book_path(@book_1)

    @book_1.reviews.each do |review|
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.user.name)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.body)
    end
  end

  it 'shows book stats' do
    review_10 = Review.create!(title: 'Review 10', rating: 5, body: 'content 10', book: @book_1, user: @user_4)

    visit book_path(@book_1)

    within '#statistics' do
      within '#top_three' do
        expect(page).to have_content(review_10.title)
        expect(page).to have_content(review_10.rating)
        expect(page).to have_content(review_10.user.name)
        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@review_3.user.name)
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.user.name)
      end

      within '#bottom_three' do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.user.name)
        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@review_3.user.name)
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.user.name)
      end

      expect(page).to have_content(3.5)
    end

  end

  describe 'there is a link to create a new review' do
    it 'creates a new review for that book' do
      visit book_path(@book_1)

      click_link "New Review"

      expect(current_path).to eq(new_book_review_path(@book_1))

      expect(page).to have_content("Create Review for #{@book_1.title}")

      fill_in :review_title, with: "New Review Title"
      fill_in :review_rating, with: 5
      fill_in :review_body, with: "New Review Body"
      fill_in :review_username, with: "Vince"

      click_button "Create Review"

      expect(current_path).to eq(book_path(@book_1))

      expect(page).to have_content(Review.last.title)
      expect(page).to have_content(Review.last.rating)
      expect(page).to have_content(Review.last.body)
      expect(page).to have_content(User.last.name)
      expect(User.last.name).to eq("Vince")
    end

    it 'cant create review if rating isnt numeric from 1 to 5' do
      visit book_path(@book_1)

      click_link "New Review"

      expect(current_path).to eq(new_book_review_path(@book_1))

      expect(page).to have_content("Create Review for #{@book_1.title}")

      fill_in :review_title, with: "New Review Title"
      fill_in :review_rating, with: 7
      fill_in :review_body, with: "New Review Body"
      fill_in :review_username, with: "Vince"

      click_button "Create Review"

      expect(Review.last).to eq(@review_9)
      expect(User.last).to eq(@user_4)


      expect(current_path).to eq(new_book_review_path(@book_1))

      expect(page).to have_content("Create Review for #{@book_1.title}")

      fill_in :review_title, with: "New Review Title"
      fill_in :review_rating, with: "something"
      fill_in :review_body, with: "New Review Body"
      fill_in :review_username, with: "Vince"

      click_button "Create Review"

      expect(Review.last).to eq(@review_9)
      expect(User.last).to eq(@user_4)

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
  end

end
