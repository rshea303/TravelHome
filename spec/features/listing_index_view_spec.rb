require 'rails_helper'

RSpec.describe "listing index" do
  let(:listing) { Listing.create({title: "Bacon Maple Crunch",
                                  description: "see title",
                                  price: 8.00,
                                  quantity_available: 2,
                                  people_per_unit: 2,
                                  private_bathroom: true,
                                  start_date: "08/10/2015",
                                  end_date: "08/12/2015",
                                  user_id: 2,
                                  country: 'USA',
                                  state: 'Colorado',
                                  city: 'Denver',
                                  zipcode: '80206',
                                  street_address: '1510 Blake St',
                                  status: 0})}

  before(:each) do
    visit root_path
    listing.pictures.create(avatar: "default_image.jpg")
  end

  it "has link to see all listings" do
    expect(page).to have_link("Browse All Listings")
  end

  it "can see all listings" do
    first(:link, "Browse All Listings").click
    expect(page).to have_content("Bacon Maple Crunch")
    expect(current_path).to eq listings_path
  end

  context "Retired listings" do
    it "do not show in index" do
      listing1 = create(:listing, title: "home", start_date: "08/10/2015", end_date: "08/13/2015")
      listing1.pictures.create(avatar: "default_image")
      listing2 = create(:listing, title: "homey home", status: 1, start_date: "08/10/2015", end_date: "08/13/2015")
      listing2.pictures.create(avatar: "default_image")

      visit listings_path
      expect(page).to have_content(listing1.title)
      expect(page).not_to have_content(listing2.title)
    end
  end
end
