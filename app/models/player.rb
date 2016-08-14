class Player < ApplicationRecord
  enum status: ['Ready to Register and Pay!', 'Very Likely to Join', 'On the Fence']
  enum age: ['30+', '28-29']

  def name
    "#{first} #{last}"
  end
end
