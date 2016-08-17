class Player < ApplicationRecord
  belongs_to :team
  belongs_to :user

  enum status: ['Ready to Register and Pay!', 'Very Likely to Join', 'On the Fence', 'Inactive']
  enum age: ['30+', '28-29']

  scope :inactive, -> { where(status: 3) }
  scope :active, -> { where('status <> 3') }

  def name
    "#{first} #{last}"
  end
end
