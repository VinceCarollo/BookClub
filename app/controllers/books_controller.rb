class BooksController < ApplicationController

  def index
    @books = Book.all
    require "pry"; binding.pry
  end

end
