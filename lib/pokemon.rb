class Pokemon
    attr_accessor :id, :name, :type, :hp, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @hp = 60
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

        result = db.execute(sql, id)[0]
        new_pokemon = Pokemon.create_from_db(result)
    end

    def self.create_from_db(array)
        # binding.pry
        new_pokemon_hash = {}
        new_pokemon_hash[:id] = array[0]
        new_pokemon_hash[:name] = array[1]
        new_pokemon_hash[:type] = array[2]
        new_pokemon_hash[:db] = @db
        pokemon = Pokemon.new(new_pokemon_hash)
        pokemon.hp = array[3]
        pokemon
    end

    def alter_hp(hp, db)
        @hp = hp
        
        sql = <<-SQL
            UPDATE pokemon SET hp = ? WHERE id = ?
        SQL

        db.execute(sql, @hp, @id)
        binding.pry
    end



end
