class UpdatePositionToIntegerInPlayers < ActiveRecord::Migration[5.0]
  def up
    Player.update_all(position: nil)
    change_column :players, :position, :integer
  end

  def down
    change_column :players, :position, :string
  end
end
