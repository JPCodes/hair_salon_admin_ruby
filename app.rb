require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'hair_salon_test'})


get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients') do
  erb(:clients)
end

get('/stylist_new') do
  erb(:stylist_form)
end

post('/stylist_new') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  title = params.fetch('title')
  image = params.fetch('image')
  bio = params.fetch('bio')
  Stylist.new({:name => name, :specialty => specialty, :title => title, :image => image, :bio => bio }).save()
  @stylists = Stylist.all()
  erb(:stylists)
end
