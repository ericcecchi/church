jQuery(".chzn-select").chosen()

jQuery(".chzn-select-deselect").chosen(allow_single_deselect: true)

jQuery("#markdown_examples").on 'show', =>
  $("#mdExamplesLink").html "Hide examples."

jQuery("#markdown_examples").on 'hide', =>
  $("#mdExamplesLink").html "Show examples."

jQuery(document).ready ->
  $(".timeago").timeago()