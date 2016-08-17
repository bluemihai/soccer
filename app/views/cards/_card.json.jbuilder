json.extract! card, :id, :game_id, :player_id, :red, :yellow, :minute, :details, :created_at, :updated_at
json.url card_url(card, format: :json)