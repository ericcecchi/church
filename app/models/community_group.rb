class CommunityGroup < Group
  include Mongoid::Document
  def cgls
    self.members.where(roles: ['cgl'])
  end
end
