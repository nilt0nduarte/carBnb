class BookingsController < ApplicationController
  before_action :set_car, except: %i[destroy edit update my_bookings my_reservations]

  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def my_bookings
    @bookings = policy_scope(Booking).where(user: current_user)
    authorize @bookings
  end

  def my_reservations
    @bookings = policy_scope(Booking).where(user: current_user)

    authorize @bookings
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car = @car
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to my_bookings_bookings_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update!(booking_params)
    redirect_to my_bookings_bookings_path, notice: "booking was successfully changed."
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to my_bookings_bookings_path, status: :see_other
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
