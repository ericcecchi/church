class Discussion < Message
  belongs_to :group
	
	def group_name
		self.group.name
  end
end
