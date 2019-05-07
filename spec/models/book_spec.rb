require "rails_helper"

describe Book do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:published)}
    it {should validate_presence_of(:pages)}
    it {should have_many(:book_authors)}
    it {should have_many(:authors).through(:book_authors)}
  end


end
