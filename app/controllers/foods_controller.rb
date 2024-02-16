class FoodsController < ApplicationController

  def index
    @facade = FoodFacade.new(params)
  end
end