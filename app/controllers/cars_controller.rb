class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
  end

  def new
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def car_params
    params.require(:car).permit(:model, :brand, :year, :price_per_day, photos: [])
  end
end
