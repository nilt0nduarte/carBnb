class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
  end

  def show
    @car = Car.find(params[:id])
  end
end
