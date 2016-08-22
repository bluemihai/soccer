class Player < ApplicationRecord
  belongs_to :team, required: false
  belongs_to :user, required: false

  enum status: ['Ready to Register and Pay!', 'Very Likely to Join', 'On the Fence', 'Inactive This (EBSSL 30+) Season']
  enum age: ['30+', '28-29']
  enum position: ['Out', 'GK', 'RWB', 'LWB', 'LCB', 'RCB', 'DM', 'RAM', 'DPM', 'S', 'CAM', 'LAM']

  scope :inactive, -> { where(status: 3) }
  scope :active, -> { where('status <> 3').where(approved: true) }
  scope :pending, -> { where('status <> 3').where(approved: false) }

  def safe_name
    return name if name && name != ''
    'No Name'
  end

  def safe_position
    return position if position && position != ''
    '??'
  end

  def self.potential_scorers(given_game)
    given_game.home_team.players.active + given_game.away_team.players.active
  end

end
