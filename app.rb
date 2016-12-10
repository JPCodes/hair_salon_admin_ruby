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

get('/stylists/:id') do
  @stylist = Stylist.find_by("id",params.fetch('id').to_i)
  erb(:stylist)
end

delete("/stylist/:id/delete") do
  @stylist = Stylist.find_by("id",params.fetch("id").to_i)
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylist/:id/edit') do
  @stylist = Stylist.find_by("id",params.fetch("id").to_i)
  erb(:stylist_edit)
end

patch('/stylist/:id/edit') do
  id = params.fetch('id').to_i
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  title = params.fetch('title')
  image = params.fetch('image')
  bio = params.fetch('bio')
  @stylist = Stylist.find_by("id",id)
  name != "" ? @stylist.update("name", name) : nil
  title != "" ? @stylist.update("title", title) : nil
  specialty != "" ? @stylist.update("specialty", specialty) : nil
  image != "" ? @stylist.update("image", image) : nil
  bio != "" ? @stylist.update("bio", bio) : nil
  @stylists = Stylist.all()
  erb(:stylists)
end

# Clients

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/client_new') do
  erb(:client_form)
end

post('/client_new') do
  name = params.fetch('name')
  next_appointment = params.fetch('next_appointment')
  Client.new({:name => name, :next_appointment => next_appointment}).save()
  @clients = Client.all()
  erb(:clients)
end

get('/clients/:id') do
  @client = Client.find_by("id",params.fetch('id').to_i)
  @stylists = Stylist.all()
  erb(:client)
end

delete("/client/:id/delete") do
  @client = Client.find_by("id",params.fetch("id").to_i)
  @client.delete()
  @clients = Client.all()
  erb(:clients)
end


get('/client/:id/edit') do
  @client = Client.find_by("id",params.fetch("id").to_i)
  @stylists = Stylist.all()
  erb(:client_edit)
end

patch('/client/:id/edit') do
  id = params.fetch('id').to_i
  name = params.fetch('name')
  next_appointment = params.fetch('next_appointment')
  @client = Client.find_by("id",id)
  name != "" ? @client.update("name", name) : nil
  next_appointment != "" ? @client.update("next_appointment", next_appointment) : nil
  params.fetch('stylist_id') != "" ? @client.update("stylist_id",params.fetch('stylist_id')) : nil
  @clients = Client.all()
  erb(:clients)
end

patch('/client/:id/add_stylist') do
  @client = Client.find_by("id",params.fetch('id').to_i)
  @client.update("stylist_id", params.fetch('stylist_id'))
  @clients = Client.all()
  erb(:clients)
end
