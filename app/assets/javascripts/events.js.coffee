# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery(document).ready ->
	$("form#new_event").on "ajax:success", (event, data, status, xhr) ->
		$('a[href="#calendar"]').tab('show');
		$('#calendar').fullCalendar 'refetchEvents'

