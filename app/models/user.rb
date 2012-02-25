class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable# , :omniauthable
  has_many :authentications, :dependent => :delete
  belongs_to :community_group
  has_and_belongs_to_many :missional_teams
  has_and_belongs_to_many :roles
  has_one :address
  
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
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  
  field :username, :type => String, :null => false, :default => ""
  field :first_name, :type => String, :null => false, :default => ""
  field :last_name, :type => String, :null => false, :default => ""
  
  ## Church
  field :birthday, :type => Date
  field :phone, :type => Integer
  field :twitter_username => String
  field :facebook_url => String
  
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username, :email, :case_sensitive => false
  attr_accessible :username, :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email']#  if email.blank?
    apply_trusted_services(omniauth) if self.new_record?
  end
  def apply_trusted_services(omniauth) 
    user_info = omniauth['user_info']
    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end 
#     if self.username.blank?
      self.username = user_info['username'] unless user_info['username'].blank?
#     end
    if self.first_name.blank?
      self.first_name = user_info['first_name'] unless user_info['first_name'].blank?
    end
    if self.last_name.blank?
      self.last_name = user_info['last_name'] unless user_info['last_name'].blank?
    end  
    if self.email.blank?
      self.email = user_info['email'] unless user_info['email'].blank?
    end 
    self.password, self.password_confirmation = String::RandomString(16)  
    self.confirmed_at, self.confirmation_sent_at = Time.now 
  end
end
