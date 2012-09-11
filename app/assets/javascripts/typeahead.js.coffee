labels = []
mapped = {}

jQuery('#users-search').typeahead
  source: (query, process) ->
    $.ajax
      url: "/users.json?q="+query
      success: (data) =>
        $.each(data, (i, item) -> 
          mapped[item.label] = item.username
          labels.push(item.label)
        )
        process(labels)
        labels = []
        
  updater: (item) ->
    window.location = "/users/#{mapped[item]}"
    item
  