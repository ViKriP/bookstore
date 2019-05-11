class ReviewsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to @review.book, notice: t('review_success')
    else
      redirect_to @review.book, alert: t('review_error')
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :comment, :rating, :book_id)
  end
end
