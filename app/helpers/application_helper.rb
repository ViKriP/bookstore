module ApplicationHelper
  def show_errors(object, field)
    object.errors.messages[field].join(', ') if object && object.errors[field]
  end

  def error_class(object, field)
    return unless object

    'has-error' if object.errors.include?(field)
  end
end
