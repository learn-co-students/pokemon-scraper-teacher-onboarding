class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id:nil, name:, type:, hp:60, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end  

  def save()
    sql = "
      INSERT INTO pokemon (name, type, hp)
      VALUES (?, ?, ?);
    "
    @db.execute(sql, @name, @type, @hp)
  end

  def self.save(name, type, db)
    pokemon = Pokemon.new({name: name, type: type, db: db})
    pokemon.save
  end

  def self.find(id, db)
    sql = "
      SELECT *
      FROM pokemon
      WHERE id = ?
    "

    record = db.execute(sql, id).first
    self.new_from_db(record, db)
  end
  
  def self.new_from_db(record, db)
    Pokemon.new(id: record[0], name: record[1], type: record[2], db: db)
  end
end
