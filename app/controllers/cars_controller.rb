class CarsController < ApplicationController
  def index
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new
  end
end
