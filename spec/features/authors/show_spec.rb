

# I see all book titles by that author
# Each book should show its year of publication
# Each book should show its number of pages
# Each book should show a list of any other authors

require "rails_helper"

describe "as a visitor" do
  describe "when I visit an authors show page" do

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

    it "displays all information for an authors books" do

      visit author_path(@author_2)
      save_and_open_page
      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.published)
        expect(page).to have_content(@book_2.pages)
    end
      within "#book-#{@book_1.id}" do

        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.published)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@author_1.name)
        expect(page).to_not have_content(@author_2.name)
    end

  end

  end

end
