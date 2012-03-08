class MissionalTeam < Group
  include Mongoid::Document
  def mtls
    self.members.where(role: :mtl)
  end
end
