class UpdateJerseyToInteger < ActiveRecord::Migration[5.0]
  def up
    saved_jerseys = Player.pluck(:id, :jersey).to_h
    Player.all.each do |player|
      player.update(jersey: nil)
    end
    remove_column :players, :jersey
    add_column :players, :jersey, :integer
    Player.all.each do |player|
      jersey_int = saved_jerseys[player.id].to_i
      player.update(jersey: jersey_int)
    end
  end

  def down
    remove_column :players, :jersey
    add_column :players, :jersey, :string
  end
end
