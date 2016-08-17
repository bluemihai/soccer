class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :game_id
      t.integer :player_id
      t.boolean :red
      t.boolean :yellow
      t.integer :minute
      t.text :details

      t.timestamps
    end
  end
end
