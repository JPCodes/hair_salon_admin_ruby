require('spec_helper')

describe(Stylist) do
  describe("#initialize") do
    it "will check initial parameters" do
      test_stylist = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      expect(test_stylist.name).to(eq('stylist'))
      expect(test_stylist.specialty).to(eq('long-hair'))
      expect(test_stylist.title).to(eq('senior stylist'))
      expect(test_stylist.image).to(eq('www.someurl.com'))
      expect(test_stylist.bio).to(eq('biography text here'))
    end
  end
  describe('#save') do
    it "save it to database" do
      test_stylist = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end
  describe('.all') do
    it "select all clients from database" do
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist1.save()
      test_stylist2 = Stylist.new({:name => "stylist2", :specialty => "short-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist2.save()
      expect(Stylist.all()).to(eq([test_stylist1, test_stylist2]))
    end
  end
  describe('#==')do
    it "override equals" do
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist2 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      expect(test_stylist1).to(eq(test_stylist2))
    end
  end
  describe("#delete") do
    it "deletes a client from database" do
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist1.save()
      test_stylist1.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end
  describe('#update') do
    it "lets you update attributes in the database" do
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist1.save()
      test_stylist1.update('name', "stylist2")
      expect(test_stylist1.name).to(eq('stylist2'))
      test_stylist1.update("specialty", "short-hair")
      expect(test_stylist1.specialty).to(eq("short-hair"))
      test_stylist1.update("title", "junior-stylist")
      expect(test_stylist1.title).to(eq("junior-stylist"))
      test_stylist1.update("image", "www.otherurl.com")
      expect(test_stylist1.image).to(eq("www.otherurl.com"))
      test_stylist1.update("bio", "some other bio")
      expect(test_stylist1.bio).to(eq("some other bio"))
    end
  end
  describe('.find_by') do
    it "will find a stylist based on an id" do
      test_stylist1 = Stylist.new({:name => "stylist", :specialty => "long-hair", :title => "senior stylist", :image => "www.someurl.com", :bio => "biography text here"})
      test_stylist1.save()
      expect(Stylist.find_by("id",test_stylist1.id)).to(eq(test_stylist1))
    end
  end
end
