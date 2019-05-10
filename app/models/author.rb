class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors
  validates_presence_of :name

  def self.exists(name)
    self.select(:name).include?(name)
  end
end
