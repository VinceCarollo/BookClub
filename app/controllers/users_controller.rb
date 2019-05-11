class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_reviews = Review.find_all_user_reviews(@user)
  end

end
