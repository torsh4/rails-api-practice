class GigsController < ApplicationController
  before_action :set_gig, only: [:show, :update, :destroy]

  # GET /gigs
  def index
    brand_name = params[:brand_name]
    creator_id = params[:creator_id]
    @gigs = Gig.all
    @gigs = @gigs.where(brand_name: brand_name) if brand_name
    @gigs = @gigs.where(creator_id: creator_id) if creator_id

    render json: @gigs
  end

  # GET /gigs/1
  def show
    param! :relationship, String, in: ["gig_payment", "creator"]

    render json: @gig, include: params[:include]
  end

  # POST /gigs
  def create
    param! :creator_id, String, required: true

    @gig = Gig.new(gig_params)
    gig_payment = GigPayment.new()

    @gig.gig_payment = gig_payment
    @gig.creator_id = params[:creator_id]

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gigs/1
  def update
    param! :creator_id, String, required: true
    param! :brand_name, String, required: true
    param! :state, String, required: true

    @gig = Gig.find(params[:id])
    if @gig.update!(brand_name: params[:brand_name], creator_id: params[:creator_id], state: params[:state])
      render json: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gigs/1
  def destroy
    @gig.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = Gig.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gig_params
      params.require(:gig).permit(:brand_name, :status, :gig_payment_id, :creator)
    end
end
