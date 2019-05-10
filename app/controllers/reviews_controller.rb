class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    new_review = Review.new(review_params)
    new_review.user = User.find_or_create_by(name: params[:review][:username])
    new_review.book = Book.find(params[:book_id])
    new_review.save

    redirect_to book_path(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :body)
  end
end
