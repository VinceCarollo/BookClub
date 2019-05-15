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

  def destroy
      @review = Review.find(params[:id])
      user = @review.user_id
      @review.destroy
      redirect_to(user_path(user))
    end

  private

  def validation(review, book)
    users = []
    book.reviews.each{|review| users << review.user_id}
    user = User.find_by(name: params[:review][:username])

    if !user.nil?
      if users.include?(user.id)
        flash.notice = "You Have Already Left a Review for This Book!"
        redirect_to new_book_review_path(book) and return
      end
    end

    if (review.rating > 5 || review.rating <= 0)
      flash.notice = "Please Enter an Integer Between 1 and 5!"
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
