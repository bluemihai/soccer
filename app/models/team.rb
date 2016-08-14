class Team < ApplicationRecord
  has_many :players
  belongs_to :division
  belongs_to :manager, class_name: 'Player', required: false
end
