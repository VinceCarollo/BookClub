
# As a Visitor,
# When I visit a book index page,
# I see all book titles in the database.
# Each book entry on the page shows the author(s) and number of
# pages in the book, and the year it was published.
require "rails_helper"

describe "as a visitor" do
  describe 'I visit book index page' do

    before :all do
      @book_1 = create(:book)
      @book_2 = create(:book)
      @book_3 = create(:book)
      @author_1 = create(:author)
      @author_2 = create(:author)
      @author_3 = create(:author)
      BookAuthor.create(book: @book_1, author: @author_1)
      BookAuthor.create(book: @book_1, author: @author_2)
      BookAuthor.create(book: @book_2, author: @author_2)
      BookAuthor.create(book: @book_3, author: @author_3)
      @review_1 = create(:review, book: @book_1)
      @review_2 = create(:review, book: @book_1)
      @review_3 = create(:review, book: @book_1)
      @review_4 = create(:review, book: @book_2)
      @review_5 = create(:review, book: @book_2)
      @review_6 = create(:review, book: @book_2)
    end

    it "displays book informtaion" do

      visit books_path

        within("#book-#{@book_1.id}")  do
          expect(page).to have_content(@book_1.title)
          expect(page).to have_content(@author_1.name)
          expect(page).to have_content(@author_2.name)
          expect(page).to have_content("Page Count: #{@book_1.pages}")
          expect(page).to have_content("Published In: #{@book_1.published}")
      end

        within("#book-#{@book_2.id}")  do
          expect(page).to have_content(@book_2.title)
          expect(page).to have_content(@author_2.name)
          expect(page).to have_content("Page Count: #{@book_2.pages}")
          expect(page).to have_content("Published In: #{@book_2.published}")
      end

        within("#book-#{@book_3.id}")  do
          expect(page).to have_content(@book_3.title)
          expect(page).to have_content(@author_3.name)
          expect(page).to have_content("Page Count: #{@book_3.pages}")
          expect(page).to have_content("Published In: #{@book_3.published}")
      end

    end


    it 'displays average book rating' do

      visit books_path
      # Book.first.review_average

      within("#book-#{@book_1.id}")  do
        expect(page).to have_content("Average Review: 3.0")
        expect(page).to have_content("Total Reviews: 3")
      end

      within("#book-#{@book_2.id}")  do

        expect(page).to have_content("Average Review: 2.67")
        expect(page).to have_content("Total Reviews: 3")
      end


    end

    it 'sorts all books' do

      visit books_path

      click_link 'Rating'
      
      expect(current_path).to eq('/books?sort=rating')

      expect(page.all('.books')[0]).to have_content(@book_3.title)
      expect(page.all('.books')[1]).to have_content(@book_2.title)
      expect(page.all('.books')[2]).to have_content(@book_1.title)

    end

  end
end
