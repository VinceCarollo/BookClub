class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :published
      t.integer :pages
      t.string :image_url, default: 'https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg'
    end
  end
end
