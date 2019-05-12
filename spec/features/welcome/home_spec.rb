require "rails_helper"

describe "as a visitor" do
  describe "when I visit the home page" do
    it "says welcome" do
      visit '/'
      save_and_open_page
      expect(page).to have_content("Welcome")
    end

    it "can redirect to books index and back" do
        visit '/'
      click_link "Books"
      expect(current_path).to eq(books_path)
      click_link "Home"
      expect(current_path).to eq('/')
    end
  end
end
