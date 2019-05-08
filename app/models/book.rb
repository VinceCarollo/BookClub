class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  validates_presence_of :title, :pages, :published

  def self.page_sort_asc
    self.order(:pages)
  end

  def self.page_sort_desc
    self.order(:pages).reverse_order
  end

  def self.published_sort_asc
    self.order(:published)
  end
  def self.published_sort_desc
    self.order(:published).reverse_order
  end
  def self.reviews_sort_asc
    self.group(:id).sort_by(&:review_average)
  end
  def self.reviews_sort_desc
    self.group(:id).sort_by(&:review_average).reverse
  end

  def review_count
    reviews.count
  end


  def review_average
    self.reviews.average(:rating)
    # require "pry"; binding.pry
  end

end
