require 'pg'

class Spaces

  attr_reader :id, :name, :description, :price, :available_from, :available_to

  def initialize(id:, name:, description:, price:, available_from:, available_to:)
    @id = id
    @name = name
    @description = description
    @price = price
    @available_from = available_from
    @available_to = available_to
  end

  def self.create(name:, description:, price:, available_from:, available_to:)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'party_dino_bnb_test')
    else
      conn = PG.connect(dbname: 'party_dino_bnb')
    end

    result = conn.exec("INSERT INTO spaces (name, description, price, available_from, available_to) VALUES('#{name}', '#{description}', '#{price}', '#{available_from}', '#{available_to}') RETURNING name, description, price, available_from, available_to")
    Spaces.new(id: result[0]['id'], name: result[0]["name"], description: result[0]["description"], price: result[0]["price"], available_from: result[0]["available_from"], available_to: result[0]["available_to"])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'party_dino_bnb_test')
    else
      conn = PG.connect(dbname: 'party_dino_bnb')
    end

    result = conn.exec("SELECT * FROM spaces")
    result.map do |row|
      Spaces.new(id: row["id"], name: row["name"], description: row["description"], price: row["price"], available_from: row["available_from"], available_to: row["available_to"])
    end
  end

  def self.find(column, value)
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'party_dino_bnb_test')
    else
      conn = PG.connect(dbname: 'party_dino_bnb')
    end

    result = conn.exec("SELECT * FROM spaces WHERE #{column} = '#{value}'")
    res = result.map do |row|
      Spaces.new(id: row["id"], name: row["name"], description: row["description"], price: row["price"], available_from: row["available_from"], available_to: row["available_to"])
    end
    search_result = res[0] 
  end

end
