class RemoveDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:gigs, :state ,from: "applied", to: nil)
    change_column_default(:gig_payments, :state ,from: "pending", to: nil)
  end
end
