class User < ActiveRecord::Base
  enum role: [:player, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :players, dependent: :nullify

  has_attached_file :photo, styles: {
    thumb: '100x100'
  }
  has_attached_file :license_photo, s3_protocol: 'https', styles: {
    full: '300x300'
  }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :license_photo, content_type: /\Aimage\/.*\Z/
  validates :dob, presence: true
  validates :email, presence: true, uniqueness: true
  validates :league_history, presence: true
  validates :liability_waiver_agreed, presence: true, acceptance: true
  validates :name, presence: true
  validate :age_at_least_28

  def phone
    day_phone || evening_phone || 'N/A'
  end

  def age
    
  end

  def first
    first_name || name.split(' ').first
  end

  def middle
    parts = name.split(' ')
    middle_name || parts.size == 3 ? parts[1] : ''
  end

  def last
    last_name || name.split(' ').last
  end

  def team
    return nil unless player
    player.team
  end

  def player
    players.first
  end

  def gravatar(size = 24)
    gravatar_id = Digest::MD5.hexdigest(email.downcase) unless email.blank?
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=monsterid"
  end

  def full_name
    name
  end

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :player
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end

  private

    def age_at_least_28
      if dob && dob > 28.years.ago.at_end_of_year
        self.errors.add(:dob, 'should be at least 28 this Dec-31')
      end
    end

end
