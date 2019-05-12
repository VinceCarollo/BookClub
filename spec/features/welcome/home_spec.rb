require "rails_helper"

describe "as a visitor" do
  describe "when I visit the home page" do
    it "says welcome" do
      visit '/'
      expect(page).to have_content("Welcome")
    end


  end
end
