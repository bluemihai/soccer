class Team < ApplicationRecord
  has_many :players
  belongs_to :division
  belongs_to :manager, class_name: 'Player', required: false

  def available_jerseys
    (0..99).to_a - players.map(&:jersey).map(&:to_i)
  end
end
