class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title, :price, :status, :frequency

  def cancel_subscription
    update(status: "Cancelled")
  end
end
