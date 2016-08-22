class AddPositionToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :position, :string
    add_column :players, :invited, :boolean
    add_column :players, :name, :string
  end
end
