class MissionalTeam < Group
  include Mongoid::Document
  has_many :mtls
end
