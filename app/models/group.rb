class Group
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  slug :name
  field :type, type: String
  
  has_and_belongs_to_many :members, class_name: 'User'
  has_and_belongs_to_many :leaders, class_name: 'User', inverse_of: :leader_groups
  has_many :discussions
  
  validates_presence_of :name, :type
  validates_uniqueness_of :name
  
  def leader_names
  	leaders.map(&:name).join(", ")
  end
  
  def members_count
  	members.count + leaders.count
  end
  
  def unread_discussions_count(user)
  	c = 0
  	self.discussions.each { |d| c += 1 if d.read_by?(user) }
  	c
  end
end
