require 'rails_helper'

describe 'when clicking on a books name anywhere' do

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

  it "links to a book show page from books index lowest stats" do
    visit books_path
    within  "#lowest_rated" do
      click_link "#{@book_1.title}"
    end
    expect(current_path).to eq(book_path(@book_1))
    click_link "Books"
    within  "#lowest_rated" do
      click_link "#{@book_2.title}"
    end
    expect(current_path).to eq(book_path(@book_2))
    click_link "Books"
    within  "#lowest_rated" do
      click_link "#{@book_3.title}"
    end
    expect(current_path).to eq(book_path(@book_3))
  end
  it "links to a book show page from books index highest stats" do
    visit books_path
    within  "#highest_rated" do
      click_link "#{@book_1.title}"
    end
    expect(current_path).to eq(book_path(@book_1))
    click_link "Books"
    within  "#highest_rated" do
      click_link "#{@book_2.title}"
    end
    expect(current_path).to eq(book_path(@book_2))
    click_link "Books"
    within  "#highest_rated" do
      click_link "#{@book_3.title}"
    end
    expect(current_path).to eq(book_path(@book_3))
  end
  it "links to a book show page from books index books section" do
    visit books_path
    within  ".main-area" do
      click_link "#{@book_1.title}"
    end
    expect(current_path).to eq(book_path(@book_1))
    click_link "Books"
    within  ".main-area" do
      click_link "#{@book_2.title}"
    end
    expect(current_path).to eq(book_path(@book_2))
    click_link "Books"
    within  ".main-area" do
      click_link "#{@book_3.title}"
    end
    expect(current_path).to eq(book_path(@book_3))
  end

  it "links to a book show page from authors show" do
    visit author_path(@author_1)
    click_link "#{@book_1.title}"
    expect(current_path).to eq(book_path(@book_1))
    visit author_path(@author_2)
    click_link "#{@book_2.title}"
    expect(current_path).to eq(book_path(@book_2))
    visit author_path(@author_2)
    click_link "#{@book_1.title}"
    expect(current_path).to eq(book_path(@book_1))
  end
  it "links to a book show page from users show" do
    visit user_path(@user_1)
    click_link "#{@book_1.title}"
    expect(current_path).to eq(book_path(@book_1))
    visit user_path(@user_1)
    click_link "#{@book_2.title}"
    expect(current_path).to eq(book_path(@book_2))
    visit user_path(@user_3)
    click_link "#{@book_3.title}"
    expect(current_path).to eq(book_path(@book_3))
  end

end
