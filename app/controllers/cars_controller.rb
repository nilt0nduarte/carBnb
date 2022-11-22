class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_cars, only: [:show, :destroy]

  def index
    @cars = policy_scope(Car)
  end

  def new
    @car = Car.new
    authorize @car
  end

  def show
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

  private

  def set_cars
    @car = Car.find(params[:id])
  end

  # def destroy
  #   @car.destroy
  #   redirect_to cars_path, status: :see_other (se pa tem que adicionar que eh o carro DO usuario)
  # end

  def car_params
    params.require(:car).permit(:model, :brand, :year, :price_per_day, :description, photos: [])
  end
end
