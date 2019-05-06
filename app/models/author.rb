class Author < ApplicationRecord
has_many :book_authors

validates_presence_of :name
end
