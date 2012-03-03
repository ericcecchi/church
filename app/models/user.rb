class User
  include Mongoid::Document
  before_save :save_username, :save_name
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable,  :lockable, :timeoutable, :confirmable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :authentications, :dependent => :delete
  belongs_to :community_group
  has_and_belongs_to_many :missional_teams
  has_and_belongs_to_many :roles
  embeds_one :address
  
  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  
  field :username,    :type => String, :null => false, :default => ""
  field :display_name,:type => String, :null => false, :default => ""
  field :first_name,  :type => String, :null => false, :default => ""
  field :last_name,   :type => String, :null => false, :default => ""
  field :name,        :type => String, :null => false, :default => ""
  
  ## Church
  field :birthday,      :type => Date, :null => false, :default => ""
  field :phone,       :type => Integer, :null => false, :default => ""
  field :twitter_username,  :type => String, :null => false, :default => ""
  field :facebook_url,    :type => String, :null => false, :default => ""
  field :user_info,     :type => String, :null => false, :default => ""
  
  validates_presence_of :display_name, :email, :first_name, :last_name, :password
  validates_uniqueness_of :display_name, :email, :case_sensitive => false
  attr_accessible :display_name, :username, :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  def save_username
    self.username = self.display_name.downcase
  end
  
  def save_name
    self.name = self.first_name + ' ' + self.last_name
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    apply_trusted_services(omniauth) if self.new_record?
  end
  
  def apply_trusted_services(omniauth) 
    user_info = omniauth['info']
    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end
    self.twitter_username = user_info['nickname'] unless user_info['nickname'].blank?
    self.facebook_url = user_info['url'] unless user_info['url'].blank?
    if self.display_name.blank?
      self.display_name = user_info['nickname'] unless user_info['nickname'].blank?
    end
    if self.first_name.blank?
      self.first_name = user_info['name'].split[0] unless user_info['name'].blank?
      self.first_name = user_info['first_name'] unless user_info['first_name'].blank?
    end
    if self.last_name.blank?
      self.last_name = user_info['name'].split[1] unless user_info['name'].blank?
      self.last_name = user_info['last_name'] unless user_info['last_name'].blank?
    end  
    if self.email.blank?
      self.email = user_info['email'] unless user_info['email'].blank?
    end 
#     self.password, self.password_confirmation = SecureRandom.hex(10)  
    self.confirmed_at, self.confirmation_sent_at = Time.now 
  end
end
