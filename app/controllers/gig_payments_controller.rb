class GigPaymentsController < ApplicationController

  def set_complete
    @gig_payment = GigPayment.find(params[:id])
    @gig_payment.set_complete!
    render json: @gig_payment
  end

end
