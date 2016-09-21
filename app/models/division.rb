class Division < ApplicationRecord
  has_many :teams
  has_many :goals, through: :teams
  has_many :players, through: :teams
  has_many :games

  def goal_scorers
    players.select { |p| p.goals_scored.size > 0 }
  end

  def goal_assisters
    players.select { |p| p.goals_assisted.size > 0 }
  end

  def standings
    teams.sort_by { |t| [-t.points, -t.goal_diff]}
  end

  def name
    letter.upcase
  end

  def full_name
    "Division #{name} (#{age}+)"
  end
end
