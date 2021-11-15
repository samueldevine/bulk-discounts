require 'rails_helper'

RSpec.describe GithubUserRepository do
  it 'exists' do
    users = GithubUserRepository.new([{login: "Micha", contributions: 10}, {login: "Bob", contributions: 20}])

    expect(users).to be_an_instance_of GithubUserRepository
  end

  it 'creates GithubUsers with logins and contributions' do
    users = GithubUserRepository.new([{login: "Micha", contributions: 10}, {login: "Bob", contributions: 20}])
    micha = GithubUser.new(login: 'Micha', contributions: 10)
    bob = GithubUser.new(login: 'Bob', contributions: 20)

    expect(users.all).to be_an Array
    expect(users.all.first).to be_a GithubUser
    expect(users.all.first.login).to eq micha.login
    expect(users.all.first.contributions).to eq micha.contributions
    expect(users.all.last.login).to eq bob.login
    expect(users.all.last.contributions).to eq bob.contributions
  end
end
