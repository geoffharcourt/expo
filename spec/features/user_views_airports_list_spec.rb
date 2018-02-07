require "rails_helper"

RSpec.feature "User views airports" do
  scenario "shows the correct title" do
    visit airports_path

    expect(page).to have_css("h1", text: "Airports")
  end

  scenario "sees all airports sorted by opening date" do
    latest_airport = create(:airport, opened_on: 9.years.ago)
    earliest_airport = create(:airport, opened_on: 10.years.ago)

    visit airports_path

    expect(airport_names).to eq([earliest_airport.name, latest_airport.name])
  end

  scenario "shows the date the airport opened" do
    opened_on = Date.new(2000)
    create(:airport, opened_on: opened_on)

    visit airports_path

    expect(find("[data-role='opened-on-date']").text).to eq("January 1, 2000")
  end

  scenario "and creates a new airport" do
    visit airports_path

    click_on "New Airport"

    expect(page).to have_css("h1", text: "New Airport")

    new_airport_name = "My New Airport"
    fill_in "Name", with: new_airport_name
    fill_in "City", with: "Wheresville"
    fill_in "Code", with: "WHR"
    fill_in "Opened on", with: "2000-01-01"
    click_on "Create Airport"

    expect(page).to have_css(
      ".flashes",
      text: "Airport was successfully created.",
    )
    expect(airport_names).to eq([new_airport_name])
  end

  def airport_names
    all("[data-role='airport-name']").map(&:text)
  end
end
