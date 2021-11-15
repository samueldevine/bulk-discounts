require 'rails_helper'

RSpec.describe GithubUser do
  it 'exists' do
    user = GithubUser.new(login: 'samueldevine', contributions: 25)

    expect(user).to be_a GithubUser
  end

  it 'has a login and contribution count' do
    user = GithubUser.new(login: 'samueldevine', contributions: 25)

    expect(user.login).to eq 'samueldevine'
    expect(user.contributions).to eq 25
  end
end
