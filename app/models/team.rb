class Team < ApplicationRecord
  has_many :players
  belongs_to :division
  belongs_to :manager, class_name: 'User', required: false 
  belongs_to :formation

  validates :name, presence: true
  validates :uniform_colors, presence: true

  def available_jerseys
    (0..99).to_a - players.map(&:jersey).map(&:to_i)
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
