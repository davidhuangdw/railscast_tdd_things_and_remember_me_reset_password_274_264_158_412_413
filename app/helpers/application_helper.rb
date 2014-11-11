module ApplicationHelper

  def input_for(column, field_method=default_field_method(column))
    is_submit = field_method == :submit_tag
    field_method = method(field_method)
    column =column.to_sym
    content_tag :div, class:'form-group' do
      if is_submit
        field_method.call column, class:'btn btn-primary'
      else
        label_tag(column) +
            field_method.call(column, params[column], class:'form-control')
      end
    end
  end

  private
  def default_field_method(column)
    column.to_s =~ /password/ ?
        :password_field_tag : :text_field_tag
  end
end
