require "rails_helper"

describe Author do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:book_authors)}
  end


end
