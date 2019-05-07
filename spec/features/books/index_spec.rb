
# As a Visitor,
# When I visit a book index page,
# I see all book titles in the database.
# Each book entry on the page shows the author(s) and number of
# pages in the book, and the year it was published.
require "rails_helper"

describe "as a visitor" do
  describe 'I visit book index page' do

    before :each do
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
    end

    it "displays book informtaion" do

      visit books_path
      Book.all.each do |book|
        within("#book-#{book.id}")  do
          expect(page).to have_content(book.title)
          expect(page).to have_content("Author: #{book.authors}")
          expect(page).to have_content("Page Count: #{book.page_count}")
          expect(page).to have_content("Published In: #{book.published}")
        end
      end

    end

  end

end
