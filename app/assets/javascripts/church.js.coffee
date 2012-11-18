padzero = (n)->
	if n < 10 then '0' + n else n

pad2zeros = (n)->
	if n < 100
		'0' + n
	
	if n < 10
		'0' + n

toISODate = (d)->
	d.getFullYear() + '-' +	padzero(d.getMonth() + 1) + '-' + padzero(d.getDate())

fnToISO = ()->
	now = new Date()
	alert(toISOString(now))
	
jQuery(document).ready ->
	$(".timeago").timeago()

	d = new Date()
	iso =	toISODate(d)
	
	$(".datepicker input").val(iso)
	$(".datepicker").attr("data-date", iso)

	$('.datepicker').datepicker {'format':'yyyy-mm-dd'}
	$('.timepicker').timepicker()
	$('.timpicker').on 'click', ->
		$('.timpicker input:text:visible:first').focus()
	
	$(".chzn-select").chosen()

	$(".chzn-select-deselect").chosen(allow_single_deselect: true)
	
	$("#markdown_examples").on 'show', =>
		$("#mdExamplesLink").html "Hide examples."
	
	$("#markdown_examples").on 'hide', =>
		$("#mdExamplesLink").html "Show examples."

	$('#eventModal').on 'shown', ->
		$('input:text:visible:first', this).focus()
	
	$('ul.dropdown-menu li a').on 'click', ->
		$('.dropdown').removeClass('open')

$.fn.focusNextInputField = ->
		this.each ->
			fields = $(this).parents('form:eq(0),body').find('button,input,textarea,select')
			index = fields.index( this )
			if index > -1 and ( index + 1 ) < fields.length
				fields.eq( index + 1 ).focus()
