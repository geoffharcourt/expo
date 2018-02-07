require "rails_helper"

RSpec.feature "User views airports" do
  scenario "shows the correct title" do
    visit airports_path

    expect(page).to have_css("h1", text: t("airports.index.title"))
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

    expect(find("[data-role='opened-on-date']").text).
      to eq(l(opened_on, format: :custom))
  end

  scenario "and creates a new airport" do
    visit airports_path

    click_on t("airports.index.add_airport")

    expect(page).to have_css("h1", text: t("airports.new.title"))

    new_airport_name = "My New Airport"
    fill_in t("simple_form.labels.airport.name"), with: new_airport_name
    fill_in t("simple_form.labels.airport.city"), with: "Wheresville"
    fill_in t("simple_form.labels.airport.code"), with: "WHR"
    fill_in t("simple_form.labels.airport.opened_on"), with: "2000-01-01"
    click_on t("helpers.submit.airport.create")

    expect(page).to have_css(".flashes", text: t("airports.create.success"))
    expect(airport_names).to eq([new_airport_name])
  end

  def airport_names
    all("[data-role='airport-name']").map(&:text)
  end
end
