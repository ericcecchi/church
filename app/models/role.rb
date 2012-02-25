class Role
  include Mongoid::Document
  has_and_belongs_to_many :users
  field :name
    
  validates_presence_of :name
  validates_uniqueness_of :name
end
