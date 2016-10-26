class ChangePublicTypeToBoolean < ActiveRecord::Migration
  def change
    change_column :decks, :public,  :boolean
  end
end
