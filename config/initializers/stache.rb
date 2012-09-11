Stache.configure do |c|
  c.template_base_path = "app/templates"  # this is probably the one you'll want to change
                                # it defaults to app/templates

  # N.B. YOU MUST TELL STACHE WHICH TO USE:
  c.use :mustache
  # and / or
#   c.use :handlebars
end