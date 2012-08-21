class Role
  include Mongoid::Document
  has_many :users
  field :name, :type => String
  key :name    
end
