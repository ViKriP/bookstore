class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :order_items, dependent: :destroy
  has_many :guest_orders, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  validates_associated :billing_address
  validates_associated :shipping_address
  validates_associated :credit_card

  aasm column: 'state', whiny_transitions: false do
    state :in_progress, initial: true
    state :in_queue, :in_delivery, :delivered, :canceled

    event :confirm do
      after do
        CheckoutCompleteMailer.order_confirm_email(user, self).deliver_now
      end

      transitions from: :in_progress, to: :in_queue
    end

    event :to_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :end_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: %i[in_progress in_queue in_delivery], to: :canceled
    end
  end

  def subtotal
    order_items.map(&:subtotal).sum
  end

  def total
    total = subtotal - discount
    total += delivery.price if delivery
    return total if total > discount

    1
  end

  def book_added?(book_id)
    order_items.any? { |item| item.book_id == book_id }
  end

  def track_number
    "R#{id}"
  end
end
