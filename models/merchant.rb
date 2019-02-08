require("pry")
require_relative("../db/sqlrunner.rb")

class Merchant

  attr_accessor :id, :name

  def initialize( merchant )
    @id = merchant["id"].to_i if merchant["id"]
    @name = merchant["name"]
  end

  def save()
    sql = "INSERT INTO merchants (name)
    VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET name = $1"
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = merchants.map{|merchant| Merchant.new(merchant)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end
end
