jQuery(document).ready ->
		$('#calendar').fullCalendar {
		
			header: {
				left: "",
				center: 'prev,title,next',
				right: 'month,basicWeek,basicDay'
			},
			
			editable: true,
			
			droppable: true,
			
			eventSources: [
				{	
					url: 'http://www.google.com/calendar/feeds/en.usa%23holiday%40group.v.calendar.google.com/public/basic'
				},
				
				{
					url: 'https://www.google.com/calendar/feeds/663amjdik5ttb06ddhtlp76s50%40group.calendar.google.com/public/basic',
					color: '#DD514C' 
				},
				
				{
					url: '/groups/events.json',
					color: '#006DCC' 
				},
				
				{
					url: '/events.json',
					color: '#5BB75B'
				}
			],
			
			eventDrop: (event,dayDelta,minuteDelta,allDay,revertFunc) ->
				$.ajax {
					type: "POST",
					url: "/events/" + event.id,
					dataType: 'json',
					data: { _method:'PUT', id: event.id, event: { start: event.start, endd: event.end } },
					error: (jqXHR, textStatus, errorThrown) ->
						alert(jqXHR.responseText)
						revertFunc()
				}
			
			
		}

