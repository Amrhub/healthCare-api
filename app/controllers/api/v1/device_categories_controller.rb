class DeviceCategoriesController < ApplicationController
  before_action :set_device_category, only: %i[show update destroy]

  # GET /device_categories
  def index
    @device_categories = DeviceCategory.all

    render json: @device_categories
  end

  # GET /device_categories/1
  def show
    render json: @device_category
  end

  # POST /device_categories
  def create
    @device_category = DeviceCategory.new(device_category_params)

    if @device_category.save
      render json: @device_category, status: :created, location: @device_category
    else
      render json: @device_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /device_categories/1
  def update
    if @device_category.update(device_category_params)
      render json: @device_category
    else
      render json: @device_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /device_categories/1
  def destroy
    @device_category.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_device_category
    @device_category = DeviceCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def device_category_params
    params.require(:device_category).permit(:device_name, :price, :device_items)
  end
end
