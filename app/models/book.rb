class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  validates_presence_of :title, :pages, :published

  def self.page_sort_asc
    self.sort(:pages)
  end

  def review_count
    reviews.count
  end

  def review_average
    self.reviews.average(:rating)
    # require "pry"; binding.pry
  end

end
