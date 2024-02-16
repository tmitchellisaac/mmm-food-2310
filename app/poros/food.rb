class Food  
  attr_reader :gtinupc,
              :description,
              :brand,
              :ingredients,
              :id

  def initialize(data)
    @id = data[:fdcId]
    @gtinupc = data[:gtinUpc]
    @description = data[:description]
    @brand = data[:brandOwner]
    @ingredients = data[:ingredients]
  end

end