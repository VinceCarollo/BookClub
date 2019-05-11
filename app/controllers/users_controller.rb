class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    case params[:sort]
    when 'newest'
      @user_reviews = Review.find_user_reviews(@user).sort_by(&:created_at).reverse
    when 'oldest'
      @user_reviews = Review.find_user_reviews(@user).sort_by(&:created_at)
    else
      @user_reviews = Review.find_user_reviews(@user)
    end
  end

end
