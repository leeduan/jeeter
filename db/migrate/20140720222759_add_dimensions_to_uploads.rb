class AddDimensionsToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :dimensions, :string
  end
end
