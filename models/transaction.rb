require("pry")
require_relative("../db/sqlrunner.rb")
require_relative("./tag.rb")
require_relative("./merchant.rb")

class Transaction

  attr_accessor :id, :amount, :tag_id, :merchant_id

  def initialize( transaction )
    @id = transaction["id"].to_i if transaction["id"]
    @amount = transaction["amount"].to_f
    @tag_id = transaction["tag_id"].to_i
    @merchant_id = transaction["merchant_id"].to_i
  end

  def self.total
    transactions = self.all()
    transaction_amounts = transactions.map{|transaction| transaction.amount}
    transactions_total = transaction_amounts.sum
    return transactions_total
  end

  def tag()
    #get tag object from transaction object's tag id
    tag = Tag.find(@tag_id)
    return tag
  end

  def merchant()
    merchant = Merchant.find(@merchant_id)
    return merchant
  end

  def save()
    sql = "INSERT INTO transactions (amount, tag_id, merchant_id)
    VALUES ($1, $2, $3) RETURNING *"
    values = [@amount, @tag_id, @merchant_id]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE transactions SET (amount, tag_id, merchant_id) = ($1, $2, $3)
    WHERE id = $4"
    values = [@amount, @tag_id, @merchant_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def destroy
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


end
