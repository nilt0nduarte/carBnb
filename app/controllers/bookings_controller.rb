class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @car = Car.find(params[:id])
    @booking.car = @car
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to car_path(@car)
    else
      render 'cars/show', status: :unprocessable_entity
    end
  end

  # private

  #   def booking_params
  #     params.require(:booking).permit()
  #   end


end
