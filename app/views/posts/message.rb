module Messages
  class Message < ::Stache::Mustache::View
  
    def date
    	context[:created_at].to_formatted_s(:short)
    end

  	def get_recipients
  		unless @recipients
  			@recipients = []
	  		context[:recipient_ids].each do |r|
	  			@recipients << User.find(r)
	  		end
	  	end
  		@recipients
  	end
  	
  	def get_sender
  		@sender = User.find(context[:sender_id]) unless @sender
  		@sender
  	end
  	
  	def markdowned
	    options = [:tables => true, :autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :lax_html_blocks => true]
	    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
	    markdown.render(context[:content]).html_safe
	  end
  	
  	def recipients
  		a = []
  		get_recipients.map do |r|
	  		a << (link_to r.name, user_path(r))
	  	end
	  	a.join(', ')
	  end
  	
  	def sender_url
  		user_url(get_sender)
  	end
  	
    def sender_name
      get_sender.name
    end
    
    def url
    	"/messages/#{context[:_id]}"
    end
    
  end
end