require('spec_helper')

describe(Client) do
  describe("#initialize") do
    it "will check initial parameters" do
      test_client = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      expect(test_client.name).to(eq('Diego'))
      expect(test_client.next_appointment).to(eq('2016-12-12 14:00:00'))
    end
  end
  describe('#save') do
    it "save it to database" do
      test_client = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end
  describe('.all') do
    it "select all clients from database" do
      test_client1 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client1.save()
      test_client2 = Client.new({:name => "Kika", :next_appointment => "2016-12-13 14:00:00"})
      test_client2.save()
      expect(Client.all()).to(eq([test_client1, test_client2]))
    end
  end
  describe('#==')do
    it "override equals" do
      test_client1 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client2 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      expect(test_client1).to(eq(test_client2))
    end
  end
  describe("#delete") do
    it "deletes a client from database" do
      test_client1 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client1.save()
      test_client1.delete()
      expect(Client.all()).to(eq([]))
    end
  end
  describe('#update') do
    it "lets you update attributes in the database" do
      test_client1 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client1.save()
      test_client1.update('name', "Kika")
      expect(test_client1.name).to(eq('Kika'))
      test_client1.update("next_appointment", "2016-12-12 14:00:00")
      expect(test_client1.next_appointment).to(eq("2016-12-12 14:00:00"))
    end
    it "update the stylist for the client" do
      test_client1 = Client.new({:name => "Diego", :next_appointment => "2016-12-12 14:00:00"})
      test_client1.save()
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist1.save()
      test_client1.update("stylist_id",test_stylist1.id)
      expect(test_client1.stylist_id).to(eq(test_stylist1.id))
    end
  end
end
