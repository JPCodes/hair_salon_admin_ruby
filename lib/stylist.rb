class Stylist
  attr_reader(:name, :specialty, :id, :title, :image, :bio,)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name, nil)
    @specialty = attributes.fetch(:specialty, nil)
    @title = attributes.fetch(:title, nil)
    @image = attributes.fetch(:image, 'http://placehold.it/300x300')
    @bio = attributes.fetch(:bio, nil)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    id = DB.exec("INSERT INTO stylists (name, specialty, title, image, bio) VALUES ('#{@name}', '#{@specialty}', '#{@title}', '#{@image}', '#{@bio}' ) RETURNING id;")
    @id = id.first.fetch("id").to_i()
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM stylists;")
    stylists = []
    results.each() do |result|
      id = result.fetch("id",nil).to_i
      name = result.fetch("name")
      specialty = result.fetch("specialty")
      title = result.fetch("title")
      image = result.fetch("image")
      bio = result.fetch("bio")
      stylists.push(Stylist.new({:name => name, :specialty => specialty, :title => title, :image => image, :bio => bio, :id => id}))
    end
    stylists
  end

  define_method(:==) do |other_stylist|
    self.name.==(other_stylist.name).&(self.id.==(other_stylist.id)).&(self.specialty.==(other_stylist.specialty)).&(self.title.==(other_stylist.title)).&(self.image.==(other_stylist.image)).&(self.bio.==(other_stylist.bio))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:update) do |name, value|
    instance_variable_set("@#{name}",value)
    DB.exec("UPDATE stylists SET #{name} = '#{value}' WHERE id = #{self.id};")
  end

  define_singleton_method(:find_by) do |name, value|
    all_stylists = Stylist.all()
    found = nil
    all_stylists.each() do |stylist|
      if eval("stylist." + eval("name")).to_s == value.to_s
        found = stylist
      end
    end
    found
  end
end
