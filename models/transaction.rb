require("pry")
require_relative("../db/sqlrunner.rb")

class Transaction

  attr_accessor :id, :amount, :tag_id, :merchant_id

  def initialize( transaction )
    @id = transaction["id"].to_i if transaction["id"]
    @amount = transaction["amount"].to_i
    @tag_id = transaction["tag_id"].to_i
    @merchant_id = transaction["merchant_id"].to_i
  end



end
