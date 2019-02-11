require("pry")
require_relative("../db/sqlrunner.rb")

class Budget

  attr_accessor :id, :amount, :time_frame

  def initialize ( budget )
    @id = budget["id"].to_i if budget["id"]
    @amount = budget["amount"]
    @time_frame = budget["time_frame"] # must be "day", "week", or "month"
  end

  def save()
    sql = "INSERT INTO budgets (amount, time_frame)
    VALUES ($1, $2) RETURNING *"
    values = [@amount, @time_frame]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE budgets SET (amount, time_frame) = ($1, $2) WHERE id = $3"
    values = [@amount, @time_frame, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM budgets"
    budgets = SqlRunner.run(sql)
    result = budgets.map{|budget| Budget.new(budget)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM budgets WHERE id = $1"
    values = [id]
    budget = SqlRunner.run(sql, values)
    result = Budget.new(budget.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run(sql)
  end

  def destroy
    sql = "DELETE FROM budgets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
