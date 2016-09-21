class Team < ApplicationRecord
  has_many :players
  has_many :games

  belongs_to :division, required: false
  belongs_to :manager, class_name: 'User', required: false 
  belongs_to :formation, required: false

  validates :name, presence: true
  # validates :uniform_colors, presence: true


  def wins

  end

  def ties
    
  end

  def losses
    
  end

  def points
    
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
