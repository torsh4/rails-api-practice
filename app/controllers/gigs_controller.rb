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

    rescue ActiveRecord::RecordNotFound => e
      logger.info(e)
      render json: { error: e }, status: :not_found
  end

  # GET /gigs/1
  def show
    param! :include, String, in: ["gig_payment", "creator"]

    render json: @gig, include: params[:include]

    rescue RailsParam::InvalidParameterError => e
      logger.info(e)
      render json: { error: e }, status: :bad_request

  end

  # POST /gigs
  def create
    param! :creator_id, String, required: true
    param! :brand_name, String, required: true

    @gig = Gig.new(creator_id: params[:creator_id], brand_name: params[:brand_name])

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gigs/1
  def update
    param! :creator_id, String, required: false
    param! :brand_name, String, required: false
    param! :state, String, required: false

    @gig = Gig.find(params[:id])

    Gig.transaction do
        @gig.update!(brand_name: params[:brand_name], creator_id: params[:creator_id])
          if params[:state] == "completed"
            @gig.set_completed!
          end
        render json: @gig

      rescue AASM::InvalidTransition => e
        logger.info(e)
        render json: {error: e}, status: :bad_request
        fail(ActiveRecord::Rollback)
      rescue ActiveRecord::RecordInvalid => e
        logger.info(e)
        render json: {error: e}, status: :not_found
        fail(ActiveRecord::Rollback)
    end

  end

  # DELETE /gigs/1
  def destroy
    @gig.destroy
  end

  def set_completed
    @gig = Gig.find(params[:id])
    @gig.set_completed!
    render json: @gig

    rescue ActiveRecord::RecordNotFound => e
      logger.info(e)
      render json: { error: e }, status: :not_found
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gig
    @gig = Gig.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
      logger.info(e)
      render json: { error: e }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def gig_params
    params.require(:gig).permit(:brand_name, :gig_payment_id, :creator)
  end
end
