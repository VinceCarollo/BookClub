# Book titles should be converted to Title Case before saving.
# Book titles should be unique within the system.
# For authors, a comma-separated list of names should be entered,
# and each author will be added to the database.
# Authors added to the database should have their names converted
# to Title Case.
# Author Names should be unique within the system.

describe "as a user" do
  describe "when I click the create book link" do
    it "creates a new book" do
      @author_1 = Author.create!(name: 'Author 1')
      @author_2 = Author.create!(name: 'Author 2')

      visit books_path
      click_link "Create Book"
      fill_in :book_title, with: "new book"
      fill_in :book_pages, with: "22"
      fill_in :book_published, with: "1988"
      fill_in :book_authors, with: "Tom wong,jones jones"
      fill_in :book_image_url, with: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg'
      click_on "Create Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(page).to have_content(new_book.title)
      expect(page).to have_content(new_book.pages)
      expect(page).to have_content(new_book.published)
      expect(new_book.authors.count).to eq(2)
      expect(page).to have_content("Tom Wong")
      expect(page).to have_content("Jones Jones")
      find "img[src='#{new_book.image_url}']"
    end

    it 'can create a book without an image' do
      @author_1 = Author.create!(name: 'Author 1')
      @author_2 = Author.create!(name: 'Author 2')

      visit books_path
      click_link "Create Book"
      fill_in :book_title, with: "new book"
      fill_in :book_pages, with: "22"
      fill_in :book_published, with: "1988"
      fill_in :book_authors, with: "Tom wong,jones jones"
      click_on "Create Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(page).to have_content(new_book.title)
      expect(page).to have_content(new_book.pages)
      expect(page).to have_content(new_book.published)
      expect(new_book.authors.count).to eq(2)
      expect(page).to have_content("Tom Wong")
      expect(page).to have_content("Jones Jones")
    end

    it "can't create a book with negative pages" do
      @author_1 = Author.create!(name: 'Author 1')
      @author_2 = Author.create!(name: 'Author 2')

      visit books_path
      click_link "Create Book"
      fill_in :book_title, with: "new book"
      fill_in :book_pages, with: "-1"
      fill_in :book_published, with: "1988"
      fill_in :book_authors, with: "Tom wong,jones jones"
      click_on "Create Book"

      expect(current_path).to eq(new_book_path)
      expect(Book.count).to eq(0)
    end
  end

end
