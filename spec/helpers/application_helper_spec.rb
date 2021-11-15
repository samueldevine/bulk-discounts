require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'Github API methods' do
    describe '#gh_facade' do
      it { expect(gh_facade).to be_a GithubFacade }
    end

    describe '#repository' do
      it { expect(repository).to be_a GithubRepo }
    end

    describe '#users' do
      it { expect(users).to be_an Array }
      it { expect(users.first).to be_a GithubUser }
    end
  end

  describe 'Nager API methods' do
    describe '#nager_facade' do
      it { expect(nager_facade).to be_a NagerFacade }
    end

    describe '#upcoming_holidays' do
      it { expect(upcoming_holidays).to be_an Array }
      it { expect(upcoming_holidays.first).to be_a NagerHoliday }
    end
  end
end
