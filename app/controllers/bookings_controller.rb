class BookingsController < ApplicationController
  before_action :set_car, except: :destroy

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car = @booking
    # @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to car_path(@car)
    else
      render 'cars/show', status: :unprocessable_entity
    end
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

    def booking_params
      params.require(:booking).permit(:start_date, :end_date)
    end


end
