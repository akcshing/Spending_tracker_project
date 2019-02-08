require("pry")
require_relative("../db/sqlrunner.rb")

class Transaction

  attr_accessor :id, :amount, :tag_id, :merchant_id

  def initialize( transaction )
    @id = transaction["id"].to_i if transaction["id"]
    @amount = transaction["amount"].to_f
    @tag_id = transaction["tag_id"].to_i
    @merchant_id = transaction["merchant_id"].to_i
  end

  def save()
    sql = "INSERT INTO transactions (amount, tag_id, merchant_id)
    VALUES ($1, $2, $3) RETURNING *"
    values = [@amount, @tag_id, @merchant_id]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end



end
