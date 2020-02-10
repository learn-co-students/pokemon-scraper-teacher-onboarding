class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    # poke = self.new(name: name, type: type, db: db)
    db.execute("insert into pokemon (name, type) values (?, ?)", name, type)
    db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
end

  def self.find(id, db)
    row = db.execute("select * from pokemon where id=?", id).first
    Pokemon.new(id: row[0], name: row[1], type:row[2], db: db)
  end


end
