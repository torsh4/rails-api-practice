require 'rails_helper'

RSpec.describe GigPaymentsController, type: :request do
  let(:creator) {Creator.create(first_name: "first_name", last_name: "last_|name")}
  let(:gig) {Gig.create(brand_name: "NEW BRAND", creator_id: creator.id, state: "completed")}
  let(:gig_payment) {GigPayment.create(gig_id: gig.id)}

  it "should change gig_payment status to complete and change his gig status to paid" do
    get "/gig_payments/#{gig_payment.id}/set_complete"

    expect(response).to have_http_status(200)
    expect(gig_payment.reload.state).to eq("complete")

    expect(gig.reload.state).to eq("paid")

  end
end