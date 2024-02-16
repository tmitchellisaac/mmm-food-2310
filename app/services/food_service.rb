class FoodService 

  def conn 
    Faraday.new(url: "https://api.nal.usda.gov/fdc/v1") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.food_bank[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def food_search(q)
    get_url("foods/search?query=#{q}")
  end

end