json.extract! game, :id, :home_id, :away_id, :kickoff, :referees_report, :context, :referee_id, :field_id, :status, :created_at, :updated_at
json.url game_url(game, format: :json)