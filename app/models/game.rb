class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_id, required: false
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_id, required: false
  belongs_to :division
  has_many :cards
  has_many :goals

  SEASON_START = Date.new(2016, 9, 11)

  enum context: [:division, :cup, :playoff]

  def self.for_team_id(tm_id)
    home = where(home_id: tm_id)
    away = where(away_id: tm_id)
    @games = (home + away).sort_by{ |g| [g.division_id, g.week] }
  end

  def teams
    [home_team, away_team]
  end

  def name
    "#{kickoff_date.strftime('%b-%d')}, Div #{division.name}: #{away_team.name} @ #{home_team.name}"
  end

  def kickoff_date
    SEASON_START + ((week - 1) * 7).days
  end

  def preview
  end

  def result
    
  end

  def home_goals
    goals.select{ |g| g.team_id == home_team.id}
  end

  def away_goals
    goals.select{ |g| g.team_id == away_team.id }
  end

end
