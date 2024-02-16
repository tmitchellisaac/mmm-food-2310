class FoodFacade
  attr_reader :q

  def initialize(params)
    @params = params
    @q = params[:q]
  end

  def foods
    service = FoodService.new.food_search(@q)[:foods]
    service.map do |food_data|
      Food.new(food_data)
    end
  end

  def total_hits
    service = FoodService.new.food_search(@q)[:totalHits]
  end
end