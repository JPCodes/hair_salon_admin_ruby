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
  specialty != "" ? @stylist.update("specialty", specialty) : nil
  title != "" ? @stylist.update("title", title) : nil
  specialty != "" ? @stylist.update("specialty", specialty) : nil
  image != "" ? @stylist.update("image", image) : nil
  bio != "" ? @stylist.update("bio", bio) : nil
  @stylists = Stylist.all()
  erb(:stylists)
end
