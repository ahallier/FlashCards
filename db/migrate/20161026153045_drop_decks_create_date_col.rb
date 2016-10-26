class DropDecksCreateDateCol < ActiveRecord::Migration
  def change
    remove_column :decks, :create_date
  end
end
