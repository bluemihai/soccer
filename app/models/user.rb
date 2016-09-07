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

  delegate :manager, to: :player, allow_nil: true

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :license_photo, content_type: /\Aimage\/.*\Z/
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :dob, presence: true, on: :update
  validates :day_phone, presence: true, on: :update
  validates :evening_phone, presence: true, on: :update
  validates_inclusion_of :league_played_before, in: [true, false], on: :update, message: 'Please choose Yes or No'
  validates :email, presence: true, uniqueness: true
  validates :liability_waiver_agreed, presence: true, acceptance: true, on: :update
  validates :name, presence: true
  validate :age_at_least_28, on: :update
  validate :listed_license_or_passport, on: :update

  def day_phone_formatted
    helpers.number_to_phone(day_phone)
  end

  def evening_phone_formatted
    helpers.number_to_phone(evening_phone)
  end

  def license_or_passport
    if !dl_license_no.blank? && !dl_issuing_state.blank?
      "Drivers License: #{dl_issuing_state.upcase} — #{dl_license_no}" 
    elsif !passport_no.blank? && !passport_country.blank?
      "Passport: #{passport_country.upcase} — #{passport_no}"
    else
      ''
    end
  end

  def state_abbrev
    if dl_issuing_state && dl_issuing_state.length == 2
      return dl_issuing_state.upcase 
    end
    if STATE_ABBREVS.keys().include? dl_issuing_state
      return STATE_ABBREVS[dl_issuing_state]
    end
    return dl_issuing_state
  end

  def license_or_passport_number_only
    if !dl_license_no.blank? && !dl_issuing_state.blank?
      "#{state_abbrev} — #{dl_license_no}"
    elsif !passport_no.blank? && !passport_country.blank?
      "#{passport_country.upcase} — #{passport_no}"
    else
      ''
    end
  end

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

  def team_name
    return nil unless team
    team.name
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

    def listed_license_or_passport
      if license_or_passport == ''
        self.errors.add(:dl_license_no, 'license/state or passport/country must be filled')
      end
    end

    def helpers
      ActionController::Base.helpers
    end

end
