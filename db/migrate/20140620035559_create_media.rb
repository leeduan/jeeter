class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :path
      t.string :content_type
      t.timestamps
    end
  end
end
