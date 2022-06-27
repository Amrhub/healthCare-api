class Api::V1::DeviceCategoriesController < ApplicationController
  before_action :set_device_category, only: %i[show update destroy]

  # GET /device_categories
  def index
    @device_categories = DeviceCategory.all

    @device_categories = @device_categories.map do |device_category|
      {
        id: device_category.id,
        name: device_category.device_name,
        items: device_category.device_items,
        price: device_category.price.to_f
      }
    end
    render json: @device_categories
  end

  def device_categories_name
    device_categories_name = DeviceCategory.all.map do |device_category|
      {
        label: device_category.device_name,
        id: device_category.id
      }
    end
    render json: device_categories_name
  end

  # GET /device_categories/1
  def show
    render json: @device_category
  end

  # POST /device_categories
  def create
    @device_category = DeviceCategory.new(device_category_params)

    if @device_category.save
      render json: {
        id: @device_category.id,
        name: @device_category.device_name,
        items: @device_category.device_items,
        price: @device_category.price.to_f
      }, status: :created
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
    params.permit(:device_name, :price, :device_items)
  end
end
