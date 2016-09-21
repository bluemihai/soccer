class Game < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_id, required: false
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_id, required: false
  belongs_to :division, required: false
  belongs_to :field

  has_many :cards
  has_many :goals

  validates :week, presence: true

  SEASON_START = Date.new(2016, 9, 11)

  enum context: [:division, :cup, :playoff]
  enum status: [:scheduled, :postponed, :played]

  scope :played, -> { where(status: 2)}

  def summary
    "Week #{week}: #{home_team}-#{away_team} #{score}"
  end

  def scheduled_sun
    SEASON_START + ((week - 1) * 7).days
  end

  def score
    "#{home_score} - #{away_score}"
  end

  def past?
    kickoff < Time.zone.now
  end

  def div
    home_team.division || 'Z'
  end

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
    SEASON_START + ((week.to_i - 1) * 7).days
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
