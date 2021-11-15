require 'rails_helper'

RSpec.describe NagerHolidayRepository do
  before :each do
    @upcoming_holidays = NagerHolidayRepository.new([
      {
        date: "2021-11-25",
        localName: "Thanksgiving Day",
        name: "Thanksgiving Day",
        countryCode: "US"
      },
      {
        date: "2021-12-25",
        localName: "Christmas Day",
        name: "Christmas Day",
        countryCode: "US"
      },
      {
        date: "2022-01-01",
        localName: "New Year's Day",
        name: "New Year's Day",
        countryCode: "US"
      },
      {
        date: "2022-01-17",
        localName: "Martin Luther King, Jr. Day",
        name: "Martin Luther King, Jr. Day",
        countryCode: "US"
      }
    ])
  end

  it 'exists' do
    expect(@upcoming_holidays).to be_an_instance_of NagerHolidayRepository
  end

  it 'only creates NagerHolidays from the first three entries' do
    expect(@upcoming_holidays.all).to be_an Array
    expect(@upcoming_holidays.all.length).to eq 3
    expect(@upcoming_holidays.all.first).to be_a NagerHoliday
    expect(@upcoming_holidays.all.last.name).to eq "New Year's Day"
  end
end
