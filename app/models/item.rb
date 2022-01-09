class Item < ApplicationRecord
  belongs_to :store
  belongs_to :free_discount, optional: true
  belongs_to :percentage_discount, optional: true
  validates :code, presence: true, uniqueness: { scope: :store_id }
  validate :free_and_percentage_discount_can_not_set_together

  def has_offer?
    free_discount.present? || percentage_discount.present?
  end

  private

  def free_and_percentage_discount_can_not_set_together
    errors.add(:base, 'Free and Percentage discount can not be set together') if free_discount && percentage_discount
  end
end
