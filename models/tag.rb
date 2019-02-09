require("pry")
require_relative("../db/sqlrunner.rb")
require_relative("./transaction.rb")

class Tag

  attr_accessor :id, :name, :total

  def initialize( tag )
    @id = tag["id"].to_i
    @name = tag["name"]
    @total = 0    #only assigned when total_spent is called. (sort_by_total too)
  end

  def self.sort_by_total # descending
    tags = self.all()
    tags_totaled = tags.each{|tag| tag.total_spent}
    tags_sorted = tags_totaled.sort_by{|tag|tag.total}
    return tags_sorted.reverse
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE tag_id = $1"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def total_spent() # inner join?
    transactions = self.transactions
    transactions_amount = transactions.map{|transaction| transaction.amount}
    transactions_total = transactions_amount.sum
    @total = transactions_total
    return transactions_total
  end

  # CRUD BELOW

  def save()
    sql = "INSERT INTO tags (name)
    VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    result = tags.map{|tag| Tag.new(tag)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    tag = SqlRunner.run(sql, values)
    result = Tag.new(tag.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def destroy
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
