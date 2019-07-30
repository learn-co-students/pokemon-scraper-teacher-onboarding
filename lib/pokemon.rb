class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES
            (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id == ?
            LIMIT 1
        SQL

        result = db.execute(sql, id)
        Pokemon.create_from_db(result)
    end

    def self.create_from_db(array)
        pokemon = Pokemon.new
        pokemon.id = array[0]
        pokemon.name = array[1]
        pokemon.type = array[2]
    end




end
