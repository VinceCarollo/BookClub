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
    @top_three_reviews = @book.reviews.top_three
    @bottom_three_reviews = @book.reviews.bottom_three
    @average_rating = @book.reviews.empty? ? 0 : @book.reviews.average_rating
  end

  def new
    @book = Book.new
  end

  def create
    authors = params[:book][:authors].split(',').map(&:titlecase)
    if Book.exists(book_params[:title])
        redirect_to new_book_path
    else
      authors.each {|author| Author.find_or_create_by(name: author)}
      @book = Book.create!(book_params)
      authors.each {|author| BookAuthor.create!(book: @book, author: Author.find_by(name: author))}
    end
    redirect_to book_path(@book)
  end

  private

  def book_params
    new_params = params.require(:book).permit(:title, :pages, :published)
    new_params[:title] = new_params[:title].titlecase
    new_params
  end

end
