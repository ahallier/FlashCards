class ChangeUsersDecksTableName < ActiveRecord::Migration
  def change
    rename_table :users_decks, :decks_users
  end
end
