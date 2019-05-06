
# As a Visitor,
# When I visit a book index page,
# I see all book titles in the database.
# Each book entry on the page shows the author(s) and number of
# pages in the book, and the year it was published.

describe "as a visitor" do
  when 'I visit book index page' do
    it "displays book informtaion" do

      visit books_path

      within("#book-#{book_1.id}")  do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Author: #{book_1.authors}")
        expect(page).to have_content("Page Count: #{book_1.page_count}")
        expect(page).to have_content("Published In: #{book_1.published}")
      end

    end

  end


end
