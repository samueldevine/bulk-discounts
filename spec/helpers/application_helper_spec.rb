require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#facade' do
    it { expect(facade).to be_a GithubFacade }
  end

  describe '#repository' do
    it { expect(repository).to be_a GithubRepo }
  end

  describe '#users' do
    it { expect(users).to be_an Array }
    it { expect(users.first).to be_a GithubUser }
  end
end
