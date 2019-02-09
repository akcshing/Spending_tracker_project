require("minitest/autorun")
require("minitest/rg")
require_relative("../transaction")
require_relative("../tag")
require_relative("../merchant")
require_relative("../../db/sqlrunner")

class TestTransaction < MiniTest::Test

  def setup
    tag_1 = Tag.new("name"=>"Food")
    tag_1.save()

    merchant_1 = Merchant.new("name"=>"McDonalds")
    merchant_1.save()

    transaction_1 = Transaction.new("amount" => 6.80, "tag_id"=>tag_1.id, "merchant_id"=>merchant_1.id)
    transaction_1.save()

    transaction_2 = Transaction.new("amount" => 5.40, "tag_id"=>tag_1.id, "merchant_id"=>merchant_1.id)
    transaction_2.save()

    transaction_3 = Transaction.new("amount" => 7.80, "tag_id"=>tag_1.id, "merchant_id"=>merchant_1.id)
    transaction_3.save()
  end

  def test_amount_total
    assert_equal(20.00, Transaction.total) # actual uses database data
  end

end
