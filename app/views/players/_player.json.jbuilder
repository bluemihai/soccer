json.extract! player, :id, :safe_name, :email, :phone, :position, :first_name, :first_initial_last, :position_request, :primary_position
json.url player_url(player, format: :json)