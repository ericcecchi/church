class Group
  include Mongoid::Document
  field :name, :type => String
  has_and_belongs_to_many :users
  has_and_belongs_to_many :leaders
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
