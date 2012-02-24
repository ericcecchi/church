module InternalHelper
  def markdown(name)
    filename = File.join('public/md/', name + '.md')
    file = File.open(filename, "rb")
    options = [:tables => true, :autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :lax_html_blocks => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    markdown.render(file.read).html_safe
  end
end
