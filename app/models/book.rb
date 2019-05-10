class Book < ApplicationRecord
  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  validates_presence_of :title, :pages, :published


  def highest_review
    reviews.order(:rating).last
  end

  def self.exists(title)
    self.select(:title).include?(title)
  end

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

    self.joins(:reviews)
        .select('avg(rating) as avg_rating, books.*')
        .group('books.id')
        .order('avg_rating')
  end

  def self.highest_3_rated_titles
    self.reviews_sort_desc.limit(3)
  end

  def self.lowest_3_rated_titles
    self.reviews_sort_asc.limit(3)
  end

  # def

  def self.reviews_sort_desc
    self.joins(:reviews)
        .select('avg(rating) as avg_rating, books.*')
        .group('books.id')
        .order('avg_rating')
        .reverse_order
  end

  def review_count
    reviews.count
  end

  def review_average
    reviews.average(:rating)
  end

end
