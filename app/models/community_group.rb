class CommunityGroup < Group
  include Mongoid::Document
  has_many :cgls
end
