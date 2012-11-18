class Event
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title
	field :subtitle
	field :description
	field :start, type: DateTime, default: DateTime.now
	field :endd, type: DateTime, default: DateTime.now
	field :all_day, type: Boolean, default: false
	field :appears, type: DateTime, default: DateTime.now
	field :expires, type: DateTime, default: ->{ start + 1.day }
	field :signup_url
	field :artwork_url
	
	validates_presence_of :title
	
	belongs_to :creator, class_name: 'User'
	belongs_to :group
	has_many :invitations
	accepts_nested_attributes_for :invitations, reject_if: :all_blank, allow_destroy: true
	has_many :needs
	accepts_nested_attributes_for :needs, reject_if: :all_blank, allow_destroy: true
	
	default_scope asc(:date)
	scope :regular, where(group_id: nil).asc(:date)
	
	def creator_name
		self.creator.name
	end
	
	def start_date
		self.start.to_date
	end

	def end_date
		self.endd.to_date
	end

	def start_time
		self.start.strftime("%I:%M %p %Z")
	end

	def end_time
		self.endd.strftime("%I:%M %p %Z")
	end
	
	def cal_json
		{ start: start, end: endd, title: title, id: _id, allDay: all_day, url: "/events/#{_id}" }
	end
end
