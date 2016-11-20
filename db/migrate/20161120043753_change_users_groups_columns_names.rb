class ChangeUsersGroupsColumnsNames < ActiveRecord::Migration
  def change
    rename_column :groups_users, :groups_id, :group_id
    rename_column :groups_users, :users_id, :user_id
  end
end
