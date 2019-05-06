class Book < ApplicationRecord
  has_many :book_authors
  validates_presence_of :title, :pages, :published


end
