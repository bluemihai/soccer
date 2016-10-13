class Player < ApplicationRecord
  belongs_to :team, required: false
  belongs_to :user, required: false
  has_many :goals_scored, class_name: 'Goal', foreign_key: 'scorer_id'
  has_many :goals_assisted, class_name: 'Goal', foreign_key: 'assister_id'

  validates :email, presence: true, uniqueness: true
  # validates :jersey, presence: true, on: :update
  # validates :jersey, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true, on: :update

  enum status: ['Ready to Register and Pay!', 'Very Likely to Join', 'On the Fence', 'Inactive This (EBSSL 30+) Season']
  enum age: ['30+', '28-29']
  enum position: ['Out', '#1 (GK)', '#2 (RWB)', '#3 (LWB)', '#4 (CB)', '#5 (CB)', '#6 (DM)', '#7 (RAM)', '#8 (DM)', '#9 (S)', '#10 (CAM)', '#11 (LAM)']

  scope :inactive, -> { where(status: 3) }
  scope :active, -> { where('status <> 3').where(approved: true) }
  scope :pending, -> { where('status <> 3').where(approved: false) }
  scope :active_or_pending, -> { where('status <> 3') }

  delegate :manager, to: :team
  delegate :full_name, :last, to: :user

  def first_name
    user.try(:first) || name.split('').first
  end

  def first_initial_last
    if user.blank?
      safe_name
    else
      "#{user.first_name[0]}. #{user.last_name}"
    end
  end

  def has_photo
    user.try(:photo).try(:url)
  end

  def has_license_photo
    user.try(:license_photo).try(:url)
  end

  def invited_or_active
    if status == 'Ready to Register and Pay!' && approved
      'Active'
    elsif status == 'Inactive This (EBSSL 30+) Season'
      'Inactive'
    elsif invited
      'Invited'
    else
      'Pending'
    end
  end

  def safe_name
    return user.name if user
    return name if name && name != ''
    'No Name'
  end

  def safe_position
    return position if position && position != ''
    '??'
  end

  def safe_jersey
    jersey
  end

  def self.potential_scorers(given_game)
    given_game.home_team.players.active + given_game.away_team.players.active
  end

end
