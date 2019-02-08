require("pry")
require_relative("../db/sqlrunner.rb")

class Tag

  attr_accessor :id, :name

  def initialize( tag )
    @id = tag["id"].to_i if tag["id"]
    @name = tag["name"]
  end

  def save()
    sql = "INSERT INTO tags (name)
    VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET name = $1"
    values = [@name]
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
