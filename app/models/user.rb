class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :players, dependent: :destroy

  has_attached_file :photo, styles: {
    thumb: '100x100'
  }

  has_attached_file :license_photo, s3_protocol: 'https', styles: {
    full: '300x300'
  }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def first
    first_name || name.split(' ').first
  end

  def team
    return nil unless player
    player.team
  end

  def player
    players.active.first
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
      self.role ||= :user
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

end
