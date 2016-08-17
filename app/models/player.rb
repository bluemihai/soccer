class Player < ApplicationRecord
  belongs_to :team
  belongs_to :user, required: false

  enum status: ['Ready to Register and Pay!', 'Very Likely to Join', 'On the Fence', 'Inactive This (EBSSL 30+) Season']
  enum age: ['30+', '28-29']

  scope :inactive, -> { where(status: 3) }
  scope :active, -> { where('status <> 3') }

  def name
    "#{first} #{last}"
  end

  def self.potential_scorers(given_game)
    given_game.home_team.players.active + given_game.away_team.players.active
  end

end
