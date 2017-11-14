require('pg')

class Bounty

  attr_accessor :name, :species, :bounty, :favourite_weapon

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty=  options['bounty'].to_i
    @favourite_weapon = options['favourite_weapon']
  end

  def save
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    sql = "INSERT INTO bounties
    (
      name,
      species,
      bounty,
      favourite_weapon
    )
    VALUES (
      $1, $2, $3, $4
    )
    RETURNING *
    "
    values = [@name, @species, @bounty, @favourite_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def update


    db = PG.connect({dbname: 'bounties', host: 'localhost'} )
    sql = "update bounties
    SET
    (name, species, bounty, favourite_weapon) =
    ($1, $2, $3, $4)
    WHERE id = $5
    "
    values = [@name, @species, @bounty, @favourite_weapon, @id]
    db.prepare("update_bounties", sql)
    db.exec_prepared("update_bounties", values)
    db.close
  end

  def delete
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "delete from bounties where id = $1"
    values = [@id]
    db.prepare('all', sql)
    bounties = db.exec_prepared('all', values)
    db.close
  end

  def self.find(id)
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "SELECT * from bounties WHERE id = $1"
    values = [id]
    db.prepare('all', sql)
    bounty = db.exec_prepared('all', values)[0]
    db.close
    return Bounty.new(bounty)

  end



end
