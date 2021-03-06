class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end
