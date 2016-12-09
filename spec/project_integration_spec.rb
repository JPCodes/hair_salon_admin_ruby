require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the home path', {:type => :feature}) do
  it('') do
    visit('/')
    expect(page).to have_content("Stylists")
  end
end
