require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('HomePath', {:type => :feature}) do
  it('checks the home path') do
    visit('/')
    expect(page).to have_content("Stylists")
  end
end
describe('Stylists', {:type => :feature}) do
  it('Add a new stylist') do
    visit('/stylists')
    click_link('Add a new Stylist here')
    fill_in("name", :with=> "Stylist1")
    fill_in("specialty", :with=> "Long-hair")
    fill_in("title", :with=> "Senior-stylist")
    fill_in("image", :with=> "www.place.com/image.jpg")
    fill_in("bio", :with=> "Somebio")
    click_button('Add Stylist')
    expect(page).to have_content("Stylist1")
  end
end
