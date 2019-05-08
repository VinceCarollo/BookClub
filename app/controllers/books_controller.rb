class BooksController < ApplicationController

  def index
    if params[:sort] == 'rating'
      @books = Book.rating_sort_asc
    else
      @books = Book.all
    end
  end

end
