class AddPositionToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :position, :integer
    add_column :players, :invited, :boolean
    add_column :players, :name, :string
    rename_column :players, :positions, :position_request
  end
end
