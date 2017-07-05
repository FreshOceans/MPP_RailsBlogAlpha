class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.string :img_src
      t.string :img_caption

      t.timestamps
    end
  end
end

# < ======= user, title, content, image_src, img_caption, comment ======= >
