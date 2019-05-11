class Review < ApplicationRecord
  attr_accessor :username

  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :body, :rating

  def find_book(book_id)
    Book.find(book_id)
  end

  def self.top_three
    self.order(:rating).reverse_order.limit(3)
  end

  def self.bottom_three
    self.order(:rating).limit(3)
  end

  def self.average_rating
    self.average(:rating)
  end

  def self.find_user_reviews(user)
    self.where(user_id: user.id)
  end

end
