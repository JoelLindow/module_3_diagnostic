require 'rails_helper'

describe "Search for local fuel stations" do
  it "Returns 10 closest fuel stations by Zip Code" do
    VCR.use_cassette("stations") do
      # As a user
      # When I visit "/"
      visit "/"

      # And I fill in the search form with 80203
      fill_in "q", with: "80203"

      # And I click "Locate"
      click_on "Locate"

      # Then I should be on page "/search" with parameters visible in the url
      expect(current_path).to eq("/search")
      # Then I should see a list of the 10 closest stations within 6 miles sorted by distance

      expect(page).to have_css(".station", count: 10)
      # And the stations should be limited to Electric and Propane
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      
      within(first(".station")) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".address")
        expect(page).to have_css(".fuel_type")
        expect(page).to have_css(".distance")
        expect(page).to have_css(".access_time")
      end
    end

  end
end
