class AddDescriptionToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :alt, :string
    add_column :uploads, :description, :text
  end
end
