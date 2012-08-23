class Group
  include Mongoid::Document
  include Mongoid::Slug
  field :name, :type => String
  slug :name
  field :type, :type => String
  has_and_belongs_to_many :users
  
  def members
    users
  end

  def leaders
  	l = []
    users.where(role: :leader).each do |u|
    	l << u.name
    end
    l
  end
  
  validates_presence_of :name, :type
  validates_uniqueness_of :name
end
