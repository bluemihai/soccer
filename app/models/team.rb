class Team < ApplicationRecord
  has_many :players
  has_many :home_games, class_name: 'Game', foreign_key: 'home_id' 
  has_many :away_games, class_name: 'Game', foreign_key: 'away_id'
  has_many :goals


  belongs_to :division, required: false
  belongs_to :manager, class_name: 'User', required: false 
  belongs_to :formation, required: false

  validates :name, presence: true
  # validates :uniform_colors, presence: true

  def update_roster(args)
    # expecting hash like {1: 14, 2: 15, 0: [20, 21, 22], nil: [30, 31, 32]}
    # update lineup
    # update bench
    # update roster_inactive
  end

  def lineup
    players.with_position.map do |player|
      [player.position, {
        first_name: player.first_name,
        id: player.id
      }]
    end.to_h
  end

  def players_by_position
    players.group_by{|p|p.position}
  end

  def bench
    players.active_subs
  end

  def roster_inactive
    players.inactive_subs
  end

  def games_played
    home_games.played + away_games.played
  end

  def games
    games_played.size
  end

  def wins
    games_played.select{ |g| g.winning_team_id == self.id }.size
  end

  def ties
    games_played.select{ |g| g.winning_team_id == nil }.size
  end

  def losses
    games - wins - ties
  end

  def points
    3 * wins + 1 * ties
  end

  def goals_for
    (home_games.played.map(&:home_score) + away_games.played.map(&:away_score)).sum
  end

  def goals_against
    (home_games.played.map(&:away_score) + away_games.played.map(&:home_score)).sum
  end

  def goal_diff
    goals_for - goals_against
  end

  def goal_diff_with_plus
    goal_diff <= 0 ? goal_diff : "+#{goal_diff}"
  end

  def goal_differential
    "#{goal_diff_with_plus} (#{goals_for}-#{goals_against})"
  end

  def available_jerseys
    (0..99).to_a - players.map(&:jersey).map(&:to_i)
  end

  def name_with_details
    "#{name}—#{short}—#{division.try(:name)}"
  end

  def short_name
    name.split(' ').map(&:first).join('')
  end

  def managers
    players.select{ |p| p.user.try(:role) == 'manager' }
  end

  def manager_names
    managers.map{ |m| m.safe_name }.join(', ')
  end
end
