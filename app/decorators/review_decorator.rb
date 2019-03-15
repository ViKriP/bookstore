class ReviewDecorator < Draper::Decorator
  delegate_all

  def review_user_fullname
    "#{user.first_name} #{user.last_name}"
  end

  def review_user_initials
    "#{user.first_name[0].capitalize}"
  end

  def review_time
    created_at.strftime('%d/%m/%y')
  end
end
