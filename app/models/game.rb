class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_id, required: false
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_id, required: false
  belongs_to :division

  SEASON_START = Date.new(2016, 9, 11)

  enum context: [:division, :cup, :playoff]

  def self.for_team_id(tm_id)
    home = where(home_id: tm_id)
    away = where(away_id: tm_id)
    @games = (home + away).sort_by{ |g| [g.division_id, g.week] }
  end

  def kickoff_date
    SEASON_START + ((week - 1) * 7).days
  end

  def preview
  end

  def result
    
  end

end
