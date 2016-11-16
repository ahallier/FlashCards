class AddPublicToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :public, :boolean
  end
end
