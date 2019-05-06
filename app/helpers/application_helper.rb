module ApplicationHelper
  def show_errors(object, field)
    object.errors.messages[field].join(', ') if object and object.errors[field]
  end

  def error_class(object, field)
    puts "--- #{object} ---"
    'has-error' if object.errors.include?(field) if object
  end
end
