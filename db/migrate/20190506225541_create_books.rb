class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :published
      t.integer :pages
      t.string :image_url
    end
  end
end
