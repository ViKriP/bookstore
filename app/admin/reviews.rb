ActiveAdmin.register Review do
  permit_params :title, :comment, :rating, :approved, :user_id, :book_id
  batch_action :destroy, false

  scope :all, group: :approve
  scope :approved, group: :approve
  scope :unapproved, group: :approve

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_review_path(review), method: :patch unless review.approved
  end

  member_action :approve, method: :patch do
    review = Review.find_by(id: params[:id])
    review.update(approved: true)
    redirect_to admin_reviews_path, notice: 'Reviews have been approved.'
  end

  index do
    selectable_column
    id_column
    column :book
    column :title
    column :comment
    column 'Date', :created_at
    column :user
    column :approved
    actions defaults: false do |review|
      item 'Show', admin_review_path(review)
      span
      item 'Approve', approve_admin_review_path(review), method: :patch unless review.approved
    end
  end

  batch_action :approve do
    batch_action_collection.update_all(approved: true)

    redirect_to collection_path, notice: 'Reviews have been approved.'
  end
end
