require("pry")
require_relative("../db/sqlrunner.rb")

class Merchant

  attr_accessor :id, :name

  def initialize( merchant )
    @id = merchant["id"].to_i if merchant["id"]
    @name = merchant["name"]
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE merchant_id = $1"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    trans_objs = transactions.map{|transaction|Transaction.new(transaction)}
    result = trans_objs.delete_if{|transaction| transaction.amount == 0}
    return result
  end

  def total()
    transactions = self.transactions
    transactions_amount = transactions.map{|transaction| transaction.amount}
    transactions_total = transactions_amount.sum
    return transactions_total
  end

  def save()
    sql = "INSERT INTO merchants (name)
    VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = merchants.map{|merchant| Merchant.new(merchant)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def destroy
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
