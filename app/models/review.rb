class Review < ApplicationRecord
  attr_accessor :username

  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :body, :rating

  def self.top_three
    self.order(:rating).reverse_order.limit(3)
  end

  def self.bottom_three
    self.order(:rating).limit(3)
  end

  def self.average_rating
    self.average(:rating)
  end
end
