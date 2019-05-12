require 'rails_helper'

RSpec.describe 'when clicking on a users name on the books show page' do
  describe 'I am takin to a page with that users information' do

    before :each do
      @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @book_3 = Book.create!(title: 'Book 3', published: 2018, pages: 33, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @book_4 = Book.create!(title: 'Book 4', published: 2002, pages: 33, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @book_5 = Book.create!(title: 'Book 5', published: 2007, pages: 33, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @user_1 = User.create!(name: "User 1")
      @user_2 = User.create!(name: "User 2")
      @review_1 = Review.create!(title: 'Review 1 Title', rating: 2, body: 'content 1', book: @book_1, user: @user_1, created_at: Time.new(2001,2,7).to_date)
      @review_2 = Review.create!(title: 'Review 2 Title', rating: 3, body: 'content 2', book: @book_2, user: @user_1, created_at: Time.new(2003,3,3).to_date)
      @review_3 = Review.create!(title: 'Review 3 Title', rating: 4, body: 'content 3', book: @book_3, user: @user_1, created_at: Time.new(2019,2,3).to_date)
      @review_4 = Review.create!(title: 'Review 4 Title', rating: 5, body: 'content 4', book: @book_4, user: @user_1, created_at: Time.new(1995,12,3).to_date)
      @review_5 = Review.create!(title: 'Review 5 Title', rating: 2, body: 'content 5', book: @book_5, user: @user_1, created_at: Time.new(1995,3,30).to_date)
      @review_6 = Review.create!(title: 'Review 6 Title', rating: 2, body: 'content 6', book: @book_1, user: @user_2, created_at: Time.new(1966,6,3).to_date)
    end

    it 'shows all reviews made by that user' do
      visit book_path(@book_1)

      click_link @user_1.name

      expect(current_path).to eq(user_path(@user_1))

      within "#review-#{@review_1.id}" do
        date_created = "#{@review_1.created_at.month}/#{@review_1.created_at.day}/#{@review_1.created_at.year}"

        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.body)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(date_created)
        find "img[src='https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg']"
      end

      within "#review-#{@review_2.id}" do
        date_created = "#{@review_2.created_at.month}/#{@review_2.created_at.day}/#{@review_2.created_at.year}"

        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.body)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(date_created)
        find "img[src='https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg']"
      end

      within "#review-#{@review_3.id}" do
        date_created = "#{@review_3.created_at.month}/#{@review_3.created_at.day}/#{@review_3.created_at.year}"

        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.body)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(date_created)
        find "img[src='https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg']"
      end

      within "#review-#{@review_4.id}" do
        date_created = "#{@review_4.created_at.month}/#{@review_4.created_at.day}/#{@review_4.created_at.year}"

        expect(page).to have_content(@review_4.title)
        expect(page).to have_content(@review_4.body)
        expect(page).to have_content(@review_4.rating)
        expect(page).to have_content(@book_4.title)
        expect(page).to have_content(date_created)
        find "img[src='https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg']"
      end

      within "#review-#{@review_5.id}" do
        date_created = "#{@review_5.created_at.month}/#{@review_5.created_at.day}/#{@review_5.created_at.year}"

        expect(page).to have_content(@review_5.title)
        expect(page).to have_content(@review_5.body)
        expect(page).to have_content(@review_5.rating)
        expect(page).to have_content(@book_5.title)
        expect(page).to have_content(date_created)
        find "img[src='https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg']"
      end

    end

    it 'can sort all reviews' do
      visit user_path(@user_1)

      click_link "Sort By Newest"

      expect(page.all('.reviews')[0]).to have_content(@review_3.title)
      expect(page.all('.reviews')[1]).to have_content(@review_2.title)
      expect(page.all('.reviews')[2]).to have_content(@review_1.title)
      expect(page.all('.reviews')[3]).to have_content(@review_4.title)
      expect(page.all('.reviews')[4]).to have_content(@review_5.title)


      click_link "Sort By Oldest"

      expect(page.all('.reviews')[0]).to have_content(@review_5.title)
      expect(page.all('.reviews')[1]).to have_content(@review_4.title)
      expect(page.all('.reviews')[2]).to have_content(@review_1.title)
      expect(page.all('.reviews')[3]).to have_content(@review_2.title)
      expect(page.all('.reviews')[4]).to have_content(@review_3.title)

    end

#     As a Visitor,
# When I visit a user's show page,
# I see a link next to each review to delete the review.
# When I delete a review I am returned to the user's show page
# Then I should no longer see that review.

  it "can delete a review" do
    visit user_path(@user_1)
    click_link "Delete Review #{@review_1.id}"
    visit user_path(@user_1)
    expect(page).to_not have_content(@review_1.title)
    expect(page).to_not have_content(@review_1.body)
    expect(current_path).to eq(user_path(@user_1))
  end


  end
end
