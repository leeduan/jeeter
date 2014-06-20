class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :file_path
      t.string :file_type
      t.timestamps
    end
  end
end
