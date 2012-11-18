class Need
  include Mongoid::Document
  
  field :name
  field :description
  field :quantity, type: Integer
  
  belongs_to :invitation
  belongs_to :event
  
end
