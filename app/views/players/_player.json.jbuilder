json.extract! player, :id, :safe_name, :email, :phone, :position, :first_initial_last, :position_request
json.url player_url(player, format: :json)