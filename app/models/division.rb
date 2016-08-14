class Division < ApplicationRecord
  has_many :teams

  def name
    letter.upcase
  end

  def full_name
    "Division #{name} (#{age}+)"
  end
end
