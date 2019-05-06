require "rails_helper"

describe Review do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
    it {should validate_presence_of(:rating)}
    it {should belong_to(:book)}
    it {should belong_to(:user)}
  end


end
