class GigPayment < ApplicationRecord
  belongs_to :gig

  def set_gig_paid
    gig = Gig.find(self.gig_id)
    gig.set_paid!
  end

  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :complete

    event :set_complete do
      transitions from: :pending, to: :complete, after: :set_gig_paid
    end
  end

end
