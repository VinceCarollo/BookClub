require "rails_helper"

describe Author do

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe 'relationships' do
    it {should have_many(:book_authors)}
    it {should have_many(:books).through(:book_authors)}
  end

  describe 'class methods' do

    it '.exists' do
      vince = Author.create!(name: 'Vince')
      patrick = Author.create!(name: 'Patrick')
      jon = Author.create!(name: 'Jon')

      expect(Author.exists(vince.name)).to be true
      expect(Author.exists('NoName')).to be false
    end

  end

end
