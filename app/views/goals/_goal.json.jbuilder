json.extract! goal, :id, :game_id, :scorer_id, :assister_id, :struck_with, :minute, :details, :created_at, :updated_at
json.url goal_url(goal, format: :json)