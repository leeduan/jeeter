class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.text    :content
      t.integer :post_type_id
      t.timestamps
    end
  end
end
