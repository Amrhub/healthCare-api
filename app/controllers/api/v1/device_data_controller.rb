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

  def show_last_minute_ecg_data
    # 60 is because we save data from device to back-end each second
    @device_data = DeviceDatum.where(device_id: params[:device_id]).last(60)
  end

  def show_avg_hourly_data
    @device_data = []
    @device_data_day = DeviceDatum.order(:created_at).group_by { |t| t.created_at.strftime('%Y-%m-%d') }

    get_average_hourly_data(@device_data_day)

  render json: @device_data
  end

  # POST /device_data
  def create
    @device_datum = DeviceDatum.new(device_datum_params)
    @device_datum.ecg = params[:ecg]
    @device_datum.gps = params[:gps]
    
    if @device_datum.save
      render json: @device_datum, status: :created
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
    params.permit(:device_id, :spo2, :heart_rate, :temperature, :ecg, :gps)
  end

  def get_average_hourly_data(device_data_day)
    device_data_day.each do |date, value|
      history = []
      data_history = []
      value.group_by { |t| t.created_at.strftime('%H') }.each do |hour, data_hourly|
        avg_data_per_hour = get_avg_data(data_hourly)

        hour = if hour.to_i < 12
                 if hour.to_i.zero?
                   '12 AM'
                 else
                   "#{hour} AM"
                 end
               else
                 "#{hour.to_i - 12} PM"
               end
        history << { time: hour, **avg_data_per_hour }
        data_history << { **avg_data_per_hour }
      end
      avg_data_per_day = get_avg_data(data_history)
      @device_data << { date:, **avg_data_per_day, history: }
    end
  end

  def get_avg_data(data)
    spo2_avg = 0
    heart_rate_avg = 0
    temperature_avg = 0

    data.each do |value|
      spo2_avg += value[:spo2]
      heart_rate_avg += value[:heart_rate]
      temperature_avg += value[:temperature]
    end

    spo2_avg /= data.length
    heart_rate_avg /= data.length
    temperature_avg /= data.length
    { heart_rate: heart_rate_avg, temperature: temperature_avg, spo2: spo2_avg }
  end
end
