module ApplicationHelper
  def show_errors(object, field)
    object.errors.messages[field].join(', ') if object.errors[field]
  end

  def error_class(object, field)
    'has-error' if object.errors.include?(field)
  end
end
