class Api::V1::DevicesController < ApplicationController
  before_action :set_device, only: %i[show update destroy]

  # GET /devices
  def index
    @devices = Device.all

    render json: @devices
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      render json: @device, status: :created, location: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def device_params
    params.permit(:device_category_id, :patient_id)
  end
end
