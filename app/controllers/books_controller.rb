class BooksController < ApplicationController

  def index
    # require "pry"; binding.pry
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
  end

end
