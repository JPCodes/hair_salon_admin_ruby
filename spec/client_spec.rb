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


end
