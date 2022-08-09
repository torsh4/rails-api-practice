class CreatorsController < ApplicationController
  before_action :set_creator, only: [:show, :update, :destroy, :set_first_name]

  # GET /creators
  def index
    param! :limit, Integer
    param! :offset, Integer
    param! :sort, String, in: ["first_name", "last_name"], default: "first_name"
    param! :sort_direction, String, in: ["ASC", "DESC"], transform: :upcase, default: "ASC"

    @creators = Creator.order("#{params[:sort]} #{params[:sort_direction]}").limit(params[:limit]).offset(params[:offset])

    render json: @creators, include: params[:include]
  end

  # GET /creators/1
  def show
    render json: @creator
  end

  # POST /creators
  def create
    param! :first_name, String, required: true
    param! :last_name, String, required: true
    @creator = Creator.new(first_name: params[:first_name], last_name: params[:last_name])

    if @creator.save
      render json: @creator, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end

    rescue RailsParam::InvalidParameterError => e
      logger.info(e)
      render json: { error: e }, status: :bad_request
  end

  # PATCH/PUT /creators/1
  def update
    param! :first_name, String, required: true
    param! :last_name, String, required: true
    if @creator.update(first_name: params[:first_name], last_name: params[:last_name])
      render json: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end

  rescue RailsParam::InvalidParameterError => e
    logger.info(e)
    render json:{error: e}, status: :bad_request
  end

  # DELETE /creators/1
  def destroy
    @creator.destroy
  end

  def search
    param! :q, String, required: true
    @creator = Creator.where("first_name LIKE ? OR last_name LIKE ?", "%" + params[:q] + "%", "%" + params[:q] + "%")
    render json: @creator
  end

  def set_first_name
    if @creator.update(first_name: params[:first_name])
      render json: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creator
      @creator = Creator.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
      logger.info(e)
      render json: { status: :not_found, error: e }
    end

    # Only allow a trusted parameter "white list" through.
    def creator_params
      params.require(:creator).permit(:first_name, :last_name)
    end

end
