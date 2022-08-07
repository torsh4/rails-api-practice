class GigPaymentsController < ApplicationController

  def set_complete
    @gig_payment = GigPayment.find(params[:id])
    @gig_payment.set_complete!
    render json: @gig_payment

  rescue ActiveRecord::RecordNotFound => e
    logger.info(e)
    render json: {status: 404, error: e}
  end
end
