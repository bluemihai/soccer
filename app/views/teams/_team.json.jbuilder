json.extract! team, :id, :name, :manager_id, :division_id, :created_at, :updated_at
json.url team_url(team, format: :json)