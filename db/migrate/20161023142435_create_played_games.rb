class CreatePlayedGames < ActiveRecord::Migration[5.0]
  def change
    create_table :played_games do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :formation_id
      t.integer :starting_position
      t.string :rsvp
      t.integer :red_card_minute
      t.integer :yellow_card_minute
      t.string :card_details
      t.text :team_comments

      t.timestamps
    end
  end
end
