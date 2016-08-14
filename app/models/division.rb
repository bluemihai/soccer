class Division < ApplicationRecord
  has_many :teams

  def name
    letter.upcase
  end
end
