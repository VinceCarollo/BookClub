require "rails_helper"

describe User do

  before each: do
    @user_1 = User.create!(name: "User 1")
    @user_2 = User.create!(name: "User 2")
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "relationships" do
    it {should have_many(:reviews)}
  end


end
