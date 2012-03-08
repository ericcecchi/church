class Group
  include Mongoid::Document
  field :name, :type => String
  has_and_belongs_to_many :users
  
  def members
    users
  end

  def to_param
    self.name
  end
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
