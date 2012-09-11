class ReadReceipt
  include Mongoid::Document
  field :read, type: Boolean, default: false
  field :archived, type: Boolean, default: false
  belongs_to :user, index: true
  belongs_to :message, index: true

  def archive
  	update_attributes(archived: true)
  end
  
  def unarchive
  	update_attributes(archived: false)
  end
  
  def mark_read
  	update_attributes(read: true)
  end
  
  def mark_unread
  	update_attributes(read: false)
  end
end
