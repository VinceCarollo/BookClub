class BooksController < ApplicationController

  def index
    # require "pry"; binding.pry
    if params[:sort] == 'pagesasc'
    @books = Book.page_sort_asc
  elsif params[:sort] == 'pagesdesc'
      @books = Book.page_sort_desc
  elsif params[:sort] == 'publishedasc'
      @books = Book.published_sort_asc
    else
      @books = Book.all
    end
  end

end
