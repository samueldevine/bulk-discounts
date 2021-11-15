require 'rails_helper'

RSpec.describe NagerService do
  it 'returns the upcoming holidays in the US' do
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
      }
    ]'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    service = NagerService.new
    json = service.upcoming_holidays

    expect(json).to be_an Array
    expect(json.first).to be_a Hash
    expect(json.first).to have_key :date
    expect(json.first).to have_key :name
  end
end
