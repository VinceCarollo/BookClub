class BooksController < ApplicationController

  def index
    if params[:sort] == 'pages'
      @books = Book.page_sort_asc
    else
      @books = Book.all
    end
  end

end
