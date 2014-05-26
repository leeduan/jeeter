class AddPublishStatusToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish_status, :boolean
  end
end
