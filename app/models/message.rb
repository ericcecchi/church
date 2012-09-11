class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  after_create :create_read_receipts
  
  field :title
  field :content
  field :read, type: Boolean, default: false
  field :markdown, type: Boolean, default: false
  field :twitter, type: Boolean, default: false
  field :facebook, type: Boolean, default: false
  field :email, type: Boolean, default: true
  
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
  has_and_belongs_to_many :recipients, class_name: 'User', inverse_of: :received_messages
  has_many :read_receipts, dependent: :destroy
  default_scope desc(:created_at)
  
  def create_read_receipts
  	recipients.each do |r|
  		r.read_receipts << ReadReceipt.create(user_id: r._id, message_id: self._id)
  	end
  end
  
  def date
  	created_at
  end
	
	def markdowned
    options = [:tables => true, :autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :lax_html_blocks => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    markdown.render(content).html_safe
  end
  
  def mark_read_by(user)
  	self.read_receipts.where(user_id: user._id).first.mark_read
  end

  def mark_unread_by(user)
  	user.read_receipts.where(message_id: self._id).first.mark_unread
  end
    
  def read_by?(user)
  	m = self.read_receipts.where(user_id: user._id).first
  	unless m.nil?
  		m.read
  	else
  		false
  	end
  end
	
  def sender_name
    self.sender.name
  end
  
	def sender_url
		"/users/#{self.sender.username}"
	end
end
