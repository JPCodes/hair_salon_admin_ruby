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
  erb(:stylists)
end

get('/clients') do
  erb(:clients)
end
get('/stylist_new') do
  erb(:stylist_form)
end
