class AddFieldsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :division_id, :integer
    add_column :games, :week, :integer
  end
end
