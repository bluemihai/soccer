class AddHasJerseyToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :has_jersey, :boolean
  end
end
