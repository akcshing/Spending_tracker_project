require("pry")
require_relative("../db/sqlrunner.rb")

class Budget_relation

  attr_accessor :id, :budget_id, :tag_id

  def initialize( relation )
    @id = relation["id"].to_i if relation["id"]
    @budget_id = relation["budget_id"].to_i
    @tag_id = relation["tag_id"].to_i
  end

  def save()
    sql = "INSERT INTO budget_relations (budget_id, tag_id)
    VALUES ($1, $2) RETURNING *"
    values = [@budget_id, @tag_id]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE budget_relations SET (budget_id, tag_id) = ($1, $2) WHERE id = $3"
    values = [@budget_id, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql ="SELECT * FROM budget_relations"
    budget_relations = SqlRunner.run(sql)
    result = budget_relations.map{|budget_relation| Budget_relation.new(budget_relation)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM budget_relations WHERE id = $1"
    values = [id]
    budget_relation = SqlRunner.run(sql, values)
    result = Budget_relation.new(budget_relation.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM budget_relations"
    SqlRunner.run(sql)
  end

  def destroy
    sql = "DELETE FROM budget_relations WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  end
