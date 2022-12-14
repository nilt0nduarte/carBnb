class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_cars, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @cars = policy_scope(Car).global_search(params[:query])
    else
      @cars = policy_scope(Car)
    end
  end

  def new
    @car = Car.new
    authorize @car
  end

  def show
    @booking = Booking.new
    @markers = {
      lat: @car.geocode[0],
      lng: @car.geocode[1],
      info_window: render_to_string(partial: "info_window", locals: { car: @car })
    }
    # raise
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car
    if @car.save
      redirect_to car_path(@car), notice: "Car was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_cars
    @cars = policy_scope(Car).where(user: current_user)
  end

  def edit
    authorize @car
  end

  def update
    authorize @car
    @car.update(car_params)
    redirect_to car_path(@car), notice: "car was successfully updated"
  end

  def destroy
    authorize @car
    @car.destroy
    redirect_to my_cars_cars_path, status: :see_other
  end

  private

  def set_cars
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :brand, :year, :price_per_day,
                                :description, :address, :longdescription, photos: [])
  end
end
