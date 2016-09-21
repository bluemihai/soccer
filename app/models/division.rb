class Division < ApplicationRecord
  has_many :teams

  def standings
    teams.sort_by { |t| [-t.points, -t.goal_differential]}
  end

  def name
    letter.upcase
  end

  def full_name
    "Division #{name} (#{age}+)"
  end
end
