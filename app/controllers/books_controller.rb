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
# require "pry"; binding.pry
  authors = params[:book][:authors].split(',').map(&:titleize)
  title = params[:book][:title].titleize
  require "pry"; binding.pry

  Author.any?{|author|author.name == "Author 1"}


  end

  private

  def book_params
    params.require(:book).permit(:title, :ages, :authors)
  end

  def titleize
    split(/(\W)+/).map(&:capitalize).join
  end

end
