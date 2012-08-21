module ApplicationHelper
 def comma_seperated_links_for(list)

#     raise TypeError, "parameter must be an array" unless list.is_a? Array 
    return if list.count == 0

    list.collect do |item| 
#       raise TypeError, "items must respond to 'name'" unless last_item.respond_to? :name
      link_to(item.name, url_for(item)) 
     end.join(", ").html_safe
  end
end
