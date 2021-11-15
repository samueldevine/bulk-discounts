require 'rails_helper'

RSpec.describe NagerFacade do
  it 'constructs a NagerHolidayRepository object' do
    mock_response = '[
      {
      "date": "2021-11-25",
      "localName": "Thanksgiving Day",
      "name": "Thanksgiving Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": 1863,
      "types": [
      "Public"
      ]
      },
      {
      "date": "2021-12-24",
      "localName": "Christmas Day",
      "name": "Christmas Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": null,
      "types": [
      "Public"
      ]
      },
      {
      "date": "2022-01-17",
      "localName": "Martin Luther King, Jr. Day",
      "name": "Martin Luther King, Jr. Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": null,
      "types": [
      "Public"
      ]
      },
      {
      "date": "2022-04-15",
      "localName": "Good Friday",
      "name": "Good Friday",
      "countryCode": "US",
      "fixed": false,
      "global": false,
      "counties": [
      "US-CT",
      "US-DE",
      "US-HI",
      "US-IN",
      "US-KY",
      "US-LA",
      "US-NC",
      "US-ND",
      "US-NJ",
      "US-TN"
      ],
      "launchYear": null,
      "types": [
      "Public"
      ]
      }
    ]'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    facade = NagerFacade.new

    expect(facade.upcoming_holidays).to be_a NagerHolidayRepository
    expect(facade.upcoming_holidays.all.first).to be_a NagerHoliday
    expect(facade.upcoming_holidays.all.first.country_code).to eq 'US'
  end
end
