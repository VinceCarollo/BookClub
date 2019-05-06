require "rails_helper"

describe User do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should have_many(:reviews)}
  end


end
