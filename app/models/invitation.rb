class Invitation
	include Mongoid::Document
	include Mongoid::Timestamps
	
	field :accepted, type: Boolean, default: false
	field :rsvp
	field :role
	
	belongs_to :user
	belongs_to :event
	has_many :needs
	
	@@responses = ["Yes","No","Maybe"]
	
	def responses
		@@responses
	end
end
