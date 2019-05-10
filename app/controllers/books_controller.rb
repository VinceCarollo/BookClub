class BooksController < ApplicationController

  def index
    User.three_ratingest_users
    case params[:sort]
    when 'pagesasc'
      @books = Book.page_sort_asc
    when 'pagesdesc'
        @books = Book.page_sort_desc
    when 'publishedasc'
        @books = Book.published_sort_asc
    when 'publisheddesc'
      @books = Book.published_sort_desc
    when 'reviewsasc'
      @books = Book.reviews_sort_asc
    when 'reviewsdesc'
      @books = Book.reviews_sort_desc
    else
      @books = Book.all
    end

    @highest_3 =Book.highest_3_rated_titles
    @lowest_3 = Book.lowest_3_rated_titles
    @three_ratingest_users = User.three_ratingest_users

  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create

  authors = params[:book][:authors].split(',').map(&:titleize)
  title = params[:book][:title].titleize
  published = params[:book][:published]
  pages = params[:book][:pages]
  if Book.exists(title)
      redirect_to new_book_path
  else
    authors.each {|author| Author.create!(name: author) unless Author.exists(author)}
    @book = Book.create!(title: title, pages: pages, published: published)
    authors.each {|author| BookAuthor.create!(book: @book, author: Author.find_by(name: author))}
  end

  redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :ages, :authors)
  end

  def titleize
    split(/(\W)+/).map(&:capitalize).join
  end

end
