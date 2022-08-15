class Gig < ApplicationRecord
  include AASM

  belongs_to :creator
  has_one :gig_payment

  aasm column: :state do
    state :applied, initial: true
    state :accepted, :completed, :paid

    event :set_completed do
      transitions from: :applied, to: :completed, after: :create_gig_payment
    end

    event :set_paid do
      transitions from: [:completed, :accepted], to: :paid
    end

  end

  def create_gig_payment
    unless self.gig_payment
      GigPayment.create(gig_id: self.id)
    end
  end

end
