require 'rails_helper'

RSpec.describe 'The welcome page' do
  it 'exists' do
    visit "/"

    expect(page).to have_content "Welcome to Bulk Discounts"
  end
end
