class User
  include Mongoid::Document
  include Mongoid::Slug
  before_save :set_username
  before_create :init_roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable,  :lockable, :timeoutable, :confirmable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :authentications, :dependent => :delete
  has_and_belongs_to_many :groups
  embeds_one :address
  belongs_to :role
  
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
  
  ## Names
#   field :username,    :type => String, :null => false, :default => ""
  field :username,:type => String, :null => false, :default => ""
  slug :username
  field :display_name,:type => String, :null => false, :default => ""
  field :first_name,  :type => String, :null => false, :default => ""
  field :last_name,   :type => String, :null => false, :default => ""
  
  ## Church
  field :birthday,          :type => Date, :null => false, :default => ""
  field :phone,             :type => Integer, :null => false, :default => ""
  field :twitter_username,  :type => String, :null => false, :default => ""
  field :facebook_url,      :type => String, :null => false, :default => ""
  
  validates_presence_of :display_name, :first_name, :last_name
  validates_uniqueness_of :display_name, :case_sensitive => false
  attr_accessible :display_name, :username, :email, :first_name, :last_name, 
                  :password, :password_confirmation, :role_id, :current_password, :remember_me, 
                  :birthday, :phone, :twitter_username,:facebook_url
  
  def admin_create
    self.display_name = self.first_name + self.last_name
    self.password = Digest::SHA1.hexdigest Time.now.to_s
  end
  
  def to_param
    username
  end
  
  def has_role? role
    !!self.role.name
  end
  
  def init_roles
    self.role = 'attender' if self.role.nil?
  end
  
  ## Use downcased username for better authentication and routes
  def set_username
    self.username = self.display_name.downcase
  end
  
  ## Concatentated name for easier printing
  def name
    self.first_name + ' ' + self.last_name
  end
  
  def update_attributes(params)
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password].blank? and params[:password_confirmation].blank?
    self.birthday = Date.civil(params['birthday(1i)'].to_i,params['birthday(2i)'].to_i,params['birthday(3i)'].to_i)
    rescue ArgumentError
    super
  end
  
  ## Apply user info returned from oauth
  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    apply_trusted_services(omniauth) if self.new_record?
  end
  
  def apply_trusted_services(omniauth) 
    user_info = omniauth['info']
    
    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end
    
    if self.twitter_username.blank?
      self.twitter_username = user_info['nickname'] unless user_info['nickname'].blank?
    end
    
    if self.facebook_url.blank?
      self.facebook_url = user_info['url'] unless user_info['url'].blank?
    end
    
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
    
    self.confirmed_at, self.confirmation_sent_at = Time.now 
  end
end
