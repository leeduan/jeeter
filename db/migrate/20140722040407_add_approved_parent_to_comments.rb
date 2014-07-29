class AddApprovedParentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ancestry, :string, after: :author_url
    add_column :comments, :approved, :boolean, after: :ancestry
    add_index :comments, :ancestry
  end
end
