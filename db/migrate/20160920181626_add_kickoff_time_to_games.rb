class AddKickoffTimeToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :kickoff_time, :time
    add_column :games, :home_score, :integer
    add_column :games, :away_score, :integer
  end
end
