module ApplicationHelper
	def active_class(controller)
		params[:controller] == controller ? 'active' : ''
	end
	
  def comma_seperated_links_for(list)

#     raise TypeError, "parameter must be an array" unless list.is_a? Array 
    return if list.count == 0

    list.collect do |item| 
#       raise TypeError, "items must respond to 'name'" unless last_item.respond_to? :name
      link_to(item.name, url_for(item)) 
     end.join(", ").html_safe
  end
  
	def timeago(time, options = {})
	  options[:class] ||= "timeago"
	  content_tag(:time, time.to_s, options.merge(datetime: time.getutc.iso8601)) if time
	end
end
