class BooksController < ApplicationController

  def index
    # require "pry"; binding.pry
    if params[:sort] == 'pagesasc'
    @books = Book.page_sort_asc
  elsif params[:sort] == 'pagesdesc'
      @books = Book.page_sort_desc
    else
      @books = Book.all
    end
  end

end
