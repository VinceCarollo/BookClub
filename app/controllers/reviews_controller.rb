class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    new_review = Review.new(review_params)
    book = Book.find(params[:book_id])
    validation(new_review, book)
  end

  private

  def validation(review, book)
    if (review.rating > 5 || review.rating <= 0)
      redirect_to new_book_review_path(book)
    elsif User.find_by(name: params[:review][:username])
      redirect_to new_book_review_path(book)
    else
      review.user = User.find_or_create_by(name: params[:review][:username])
      review.book = book
      review.save
      redirect_to book_path(book)
    end
  end

  def review_params
    params.require(:review).permit(:title, :rating, :body)
  end
end
