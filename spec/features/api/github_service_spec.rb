require 'rails_helper'

RSpec.describe GithubService do
  it 'returns data about a repo' do
    mock_response = '{
      "name": "little-esty-shop"
    }'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    service = GithubService.new
    json = service.repository

    expect(json).to be_a Hash
    expect(json).to have_key :name
  end

  it "returns data about a repository's contributors" do
    mock_response = '[{
      "login": "samueldevine",
      "contributions": 25
    },
    {
      "login": "michab17",
      "contributions": 20
    }]'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    service = GithubService.new
    json = service.users

    expect(json).to be_an Array
    expect(json.first).to be_a Hash
    expect(json.first).to have_key :login
    expect(json.first).to have_key :contributions
  end
end
