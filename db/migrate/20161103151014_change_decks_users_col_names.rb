class ChangeDecksUsersColNames < ActiveRecord::Migration
  def change
    rename_column :decks_users, :decks_id, :deck_id
    rename_column :decks_users, :users_id, :user_id
  end
end
