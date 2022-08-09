require 'rails_helper'

RSpec.describe Gig, type: :model do
  it "is Gig" do
    gig = Gig.create(brand_name: "BRAND")
    expect(gig.brand_name).to eq("BRAND")
  end
end
