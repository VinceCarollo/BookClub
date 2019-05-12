
# As a Visitor,
# When I visit a book index page,
# I see all book titles in the database.
# Each book entry on the page shows the author(s) and number of
# pages in the book, and the year it was published.
require "rails_helper"

describe "as a visitor" do
  describe 'I visit book index page' do

    before :each do
      @book_1 = Book.create!(title: 'Book 1', published: 1967, pages: 155, image_url: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg')
      @book_2 = Book.create!(title: 'Book 2', published: 1965, pages: 245, image_url: 'https://www.csparks.com/Bookbinding/001%20-%20A%20small%20book.jpg')
      @book_3 = Book.create!(title: 'Book 3', published: 1975, pages: 33, image_url: 'https://thumbs-prod.si-cdn.com/ufPRE9RHUDHqQdOsLvYHhJAxy1k=/fit-in/1600x0/https://public-media.si-cdn.com/filer/91/91/91910c23-cae4-46f8-b7c9-e2b22b8c1710/lostbook.jpg')
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

    it "displays book informtaion" do

      visit books_path
      within("#book-#{@book_1.id}")  do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@author_1.name)
        expect(page).to have_content(@author_2.name)
        expect(page).to have_content("Page Count: #{@book_1.pages}")
        expect(page).to have_content("Published In: #{@book_1.published}")
        find "img[src='#{@book_1.image_url}']"
      end
      within("#book-#{@book_2.id}")  do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@author_2.name)
        expect(page).to have_content("Page Count: #{@book_2.pages}")
        expect(page).to have_content("Published In: #{@book_2.published}")
        find "img[src='#{@book_2.image_url}']"
      end
      within("#book-#{@book_3.id}")  do
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(@author_3.name)
        expect(page).to have_content("Page Count: #{@book_3.pages}")
        expect(page).to have_content("Published In: #{@book_3.published}")
        find "img[src='#{@book_3.image_url}']"
      end
    end


    it 'displays average book rating' do
      visit books_path

      within("#book-#{@book_1.id}")  do
        expect(page).to have_content("Average Review: 3.0")
        expect(page).to have_content("Total Reviews: 3")
      end
      within("#book-#{@book_2.id}")  do
        expect(page).to have_content("Average Review: 3.33")
        expect(page).to have_content("Total Reviews: 3")
      end
    end

    it 'sorts all books' do

      visit books_path

      click_link 'Page Count Asc'
      expect(page.all('.books')[0]).to have_content(@book_3.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_2.title)

      click_link 'Page Count Desc'
      expect(page.all('.books')[0]).to have_content(@book_2.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_3.title)

      click_link 'Published Asc'
      expect(page.all('.books')[0]).to have_content(@book_2.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_3.title)

      click_link 'Published Desc'
      expect(page.all('.books')[0]).to have_content(@book_3.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_2.title)

      click_link 'Reviews Asc'

      expect(page.all('.books')[0]).to have_content(@book_3.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_2.title)

      click_link 'Reviews Desc'

      expect(page.all('.books')[0]).to have_content(@book_2.title)
      expect(page.all('.books')[1]).to have_content(@book_1.title)
      expect(page.all('.books')[2]).to have_content(@book_3.title)

    end

    it 'shows statistics' do
      book_4 = Book.create!(title: 'Book 4', published: 2018, pages: 223)
      book_5 = Book.create!(title: 'Book 5', published: 1955, pages: 478)
      review_8 = Review.create!(title: 'Review 8', rating: 4, body: 'content 7', book: book_4, user: @user_3)
      review_9 = Review.create!(title: 'Review 9', rating: 5, body: 'content 7', book: book_5, user: @user_4)
      visit books_path

      within '#statistics' do
        within '#highest_rated' do
          expect(page).to have_content("Highest Rated:")
          within "#book-#{book_4.id}-highest-stats" do
            expect(page).to have_content(book_4.review_average)
            expect(page).to have_content(book_4.title)
          end
          within "#book-#{@book_2.id}-highest-stats" do
            expect(page).to have_content(@book_2.review_average)
            expect(page).to have_content(@book_2.title)
          end
          within "#book-#{book_5.id}-highest-stats" do
            expect(page).to have_content(book_5.review_average)
            expect(page).to have_content(book_5.title)
          end
        end

        within '#lowest_rated' do
          within "#book-#{@book_1.id}-lowest-stats" do
            expect(page).to have_content(@book_1.review_average)
            expect(page).to have_content(@book_1.title)
          end
          within "#book-#{@book_2.id}-lowest-stats" do
            expect(page).to have_content(@book_2.review_average)
            expect(page).to have_content(@book_2.title)
          end
          within "#book-#{@book_3.id}-lowest-stats" do
            expect(page).to have_content(@book_3.review_average)
            expect(page).to have_content(@book_3.title)
          end
        end

        within '#most_ratings' do
          expect(page).to have_content("Most Reviews:")
          within  "#ratings-#{@user_1.id}" do
            expect(page).to have_content(@user_1.name)
            expect(page).to have_content(@user_1.review_count)
          end
        within  "#ratings-#{@user_2.id}" do
          expect(page).to have_content(@user_2.name)
          expect(page).to have_content(@user_2.review_count)
        end
        within  "#ratings-#{@user_3.id}" do
          expect(page).to have_content(@user_3.name)
          expect(page).to have_content(@user_3.review_count)
        end
      end

    end
end
  end
end
