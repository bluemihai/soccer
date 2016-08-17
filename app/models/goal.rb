class Goal < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :scorer, class_name: 'Player'
  belongs_to :assister, class_name: 'Player'

  enum struck_with: [:Head, :"Left Foot", :"Right Foot", :Other]

  def scorer_name
    scorer.name
  end

  def assister_name
    assister.name
  end
end
