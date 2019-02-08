require("minitest/autorun")
require("minitest/rg")
require_relative("../transaction")
require_relative("../tag")
require_relative("../merchant")

class TestTransaction < MiniTest::Test

  def setup
    tag_1 = Tag.new("name"=>"Food")
    merchant_1 = Merchant.new("name"=>"McDonalds")

    transaction_1 = Transaction.new("amount" => 6.80, "tag_id"=>tag_1.id, "merchant"=>merchant_1.id)
    transaction_2 = Transaction.new("amount" => 5.40, "tag_id"=>tag_1.id, "merchant"=>merchant_1.id)
    transaction_3 = Transaction.new("amount" => 7.80, "tag_id"=>tag_1.id, "merchant"=>merchant_1.id)

  end

  def test_amount_total
    assert_equal(20.00, Transaction.total) # actual uses database data
  end

end
