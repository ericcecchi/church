class CommunityGroup < Group
  include Mongoid::Document
  def cgls
    self.members.where(role: :mtl)
  end
end
