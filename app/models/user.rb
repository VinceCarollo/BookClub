class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :role

  enum role: ['default', 'admin']

  def self.three_ratingest_users
    self.joins(:reviews)
    .select('users.*, count(reviews.user_id)')
    .group('users.id')
    .order('count desc')
    .limit(3)
  end

  def review_count
    reviews.count
  end

end
