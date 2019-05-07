class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors


  validates_presence_of :title, :pages, :published


  def review_count
    self.reviews.count
  end
  def review_average
  end


end
