require "rails_helper"

describe Author do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:books)}
    it {should belong_to(:books)}
  end


end
