class Client
  attr_reader(:name, :next_appointment, :id, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name, nil)
    @next_appointment = attributes.fetch(:next_appointment, nil)
    @stylist_id = attributes.fetch(:stylist_id, 0)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    id = DB.exec("INSERT INTO clients (name, next_appointment, stylist_id ) VALUES ('#{@name}', '#{@next_appointment}', #{@stylist_id}) RETURNING id;")
    @id = id.first.fetch("id").to_i()
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM clients;")
    clients = []
    results.each() do |result|
      id = result.fetch("id").to_i
      name = result.fetch("name")
      next_appointment = result.fetch("next_appointment")
      stylist_id = result.fetch("stylist_id").to_i
      clients.push(Client.new({:name => name, :next_appointment => next_appointment, :stylist_id => stylist_id, :id => id}))
    end
    clients
  end

  define_method(:==) do |other_client|
    self.name.==(other_client.name).&(self.id.==(other_client.id)).&(self.next_appointment.==(other_client.next_appointment)).&(self.stylist_id.==(other_client.stylist_id))
  end

end
