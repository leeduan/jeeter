class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text    :content
      t.integer :post_id
      t.integer :user_id
      t.string  :author_name
      t.string  :author_email
      t.string  :author_url
      t.timestamps
    end
  end
end
