class AddLeagueHistoryFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :league_played_before, :boolean
    add_column :users, :league_past_when, :string
    add_column :users, :league_past_team_name, :string
    add_column :users, :league_past_your_name, :string
  end
end
