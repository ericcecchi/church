class MTL < Leader
  include Mongoid::Document
  belongs_to :missional_team
end