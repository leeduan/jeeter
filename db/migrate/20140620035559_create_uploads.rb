class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :user_id
      t.string  :file_path
      t.string  :file_type
      t.timestamps
    end
  end
end
