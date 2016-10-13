json.extract! player, :id, :safe_name, :email, :phone, :position, :first_initial_last
json.url player_url(player, format: :json)