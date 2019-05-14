require 'rails_helper'


  describe "when I visit a page that isnt welcome I see a footer" do

    it "has footer on book index" do
      visit books_path
      find_link("Back To Top")
    end

    it "has footer on author index" do
      author_1 = Author.create!(name: 'Author 1')
      visit author_path(author_1)
      find_link("Back To Top")
    end

    it "has no footer" do
      visit '/'
      expect {find_link("Back To Top")}.to raise_error(Capybara::ElementNotFound)
    end


  end
