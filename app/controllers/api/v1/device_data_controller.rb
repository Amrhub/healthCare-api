class Api::V1::DeviceDataController < ApplicationController
  before_action :set_device_datum, only: %i[show update destroy]

  # GET /device_data
  def index
    @device_data = DeviceDatum.all

    render json: @device_data
  end

  # GET /device_data/1
  def show
    render json: @device_datum
  end

  # POST /device_data
  def create
    @device_datum = DeviceDatum.new(device_datum_params)

    if @device_datum.save
      render json: @device_datum, status: :created, location: @device_datum
    else
      render json: @device_datum.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /device_data/1
  def update
    if @device_datum.update(device_datum_params)
      render json: @device_datum
    else
      render json: @device_datum.errors, status: :unprocessable_entity
    end
  end

  # DELETE /device_data/1
  def destroy
    @device_datum.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_device_datum
    @device_datum = DeviceDatum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def device_datum_params
    params.require(:device_datum).permit(:device_id, :user_id, :spo2, :heart_rate, :temperature)
  end
end
