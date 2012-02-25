class Cgl < Leader
  include Mongoid::Document
  belongs_to :community_group
end
