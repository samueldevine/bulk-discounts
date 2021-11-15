require 'rails_helper'

RSpec.describe GithubFacade do
  it 'constructs a GithubRepo object' do
    mock_response = '{
      "name": "little-esty-shop"
    }'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    facade = GithubFacade.new

    expect(facade.repository).to be_a GithubRepo
    expect(facade.repository.name).to eq "little-esty-shop"
  end

  it 'contructs a GithubUserRepository object' do
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

    facade = GithubFacade.new

    expect(facade.users).to be_a GithubUserRepository
    expect(facade.users.all.first).to be_a GithubUser
    expect(facade.users.all.first.login).to eq 'samueldevine'
    expect(facade.users.all.first.contributions).to eq 25
  end
end
