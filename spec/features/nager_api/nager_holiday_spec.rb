require 'rails_helper'

RSpec.describe NagerHoliday do
  it 'exists' do
    xmas = NagerHoliday.new({
      date: "2021-12-25",
      localName: "Christmas Day",
      name: "Christmas Day",
      countryCode: "US"
    })

    expect(xmas).to be_a NagerHoliday
  end

  it 'has readable attributes' do
    xmas = NagerHoliday.new({
      date: "2021-12-25",
      localName: "Christmas Day",
      name: "Christmas Day",
      countryCode: "US"
    })

    expect(xmas.date).to eq '2021-12-25'
    expect(xmas.local_name).to eq 'Christmas Day'
    expect(xmas.name).to eq 'Christmas Day'
    expect(xmas.country_code).to eq 'US'
  end
end
