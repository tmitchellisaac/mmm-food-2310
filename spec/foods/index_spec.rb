require "rails_helper"


RSpec.describe "index page", type: :feature do
  it "has an index page" do

    # As a user,
    # When I visit "/"
    # And I fill in the search form with "sweet potatoes" (Note: Use the existing search form)
    # And I click "Search"
    # Then I should be on page "/foods"
    # And I should see a total number of items returned by the search. (Note: "sweet potatoes" should yield >30,000 results)
    # Then I should see a list of TEN foods that contain the ingredient "sweet potatoes"
    # And for each of the foods I should see:
    # - The food's GTIN/UPC code
    # - The food's description
    # - The food's Brand Owner
    # - The food's ingredients

    sweet_potatoes = File.read("spec/fixtures/sweet_potatoes_10.json") 
    
    stub_request(:get, "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=2GFnaNUf1bybg18LAm1OkRbuLURgB4LLCMba1bJB&query=sweet%20potatoes").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: sweet_potatoes, headers: {})

    visit root_path

    fill_in :q, with: "sweet potatoes"
    click_on "Search"
    expect(current_path).to eq(foods_path)

    expect(page).to have_content(56231)

    expect(page).to have_content("832298010009")
    expect(page).to have_content("SWEET POTATOES")
    expect(page).to have_content("NOT A BRANDED ITEM")
    expect(page).to have_content("")
    
    expect(page).to have_content("070560951975")
    expect(page).to have_content("SWEET POTATOES")
    expect(page).to have_content("The Pictsweet Company")
    expect(page).to have_content("SWEET POTATOES.")

    facade = FoodFacade.new(q: "sweet potatoes")
    expect(facade.foods.count).to eq(10)
  end
end