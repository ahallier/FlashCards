class AddOwnerToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :owner_id, :integer
  end
end
