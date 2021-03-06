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

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  define_method(:update) do |name, value|
    instance_variable_set("@#{name}",value)
    DB.exec("UPDATE clients SET #{name} = '#{value}' WHERE id = #{self.id};")
  end
  define_singleton_method(:find_by) do |name, value|
    clients = Client.all()
    found = nil
    clients.each() do |client|
      if eval("client." + eval("name")).to_s == value.to_s
        found = client
      end
    end
    found
  end

end
