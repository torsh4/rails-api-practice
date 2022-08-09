require 'rails_helper'

RSpec.describe GigsController, type: :request do
  let(:creator) {Creator.create(first_name: "first_name", last_name: "last_|name")}
  let(:gig) {Gig.create(brand_name: "NEW BRAND", creator_id: creator.id)}

  it "should crate gig" do
    post '/gigs', params: {brand_name: "NEW BRAND", creator_id: creator.id}
    expect(response).to have_http_status(201)
    end

  it "should change gig status to completed and create gig_payment" do
    get "/gigs/#{gig.id}/set_completed", params: {brand_name: "NEW BRAND", creator_id: creator.id}

    expect(response).to have_http_status(200)
    expect(gig.reload.state).to eq("completed")

    gig_payment = gig.gig_payment

    expect(gig_payment.gig_id).to eq(gig.id)
    expect(gig_payment.state).to eq("pending")

  end

  it("should not update gig") do
    put "/gigs/#{gig.id}", params: {brand_name: "BRAND NEW NAME", creator_id: 89767689}
    expect(response).to have_http_status(404)
    expect(gig.reload.brand_name).to eq("NEW BRAND")
  end

end