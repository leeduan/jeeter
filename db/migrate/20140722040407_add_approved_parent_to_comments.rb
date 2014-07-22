class AddApprovedParentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer, after: :author_url
    add_column :comments, :approved, :boolean, after: :parent_id
  end
end
