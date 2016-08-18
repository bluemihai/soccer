class AddApprovedToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :approved, :boolean, default: false
  end
end
