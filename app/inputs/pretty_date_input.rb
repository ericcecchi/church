class PrettyDateInput < SimpleForm::Inputs::Base
  def input
    "<div class='input-append datepicker' data-date='' data-date-format='yyyy-mm-dd'>#{@builder.text_field(attribute_name, input_html_options)}<span class='add-on'><i class='icon-th'></i></span></div>".html_safe
  end
end