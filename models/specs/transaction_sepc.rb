require("minitest/autorun")
require("minitest/rg")
require_relative("../transaction")
require_relative("../tag")
require_relative("../merchant")
require_relative("../../db/sqlrunner")

class TestTransaction < MiniTest::Test

  def setup
    @tag_1 = Tag.new("name"=>"Food")
    @tag_1.save()
    @tag_2 = Tag.new("name"=>"Clothes")
    @tag_2.save()

    @merchant_1 = Merchant.new("name"=>"McDonalds")
    @merchant_1.save()
    @merchant_2 = Merchant.new("name"=>"UNIQLO")
    @merchant_2.save()

    @transaction_1 = Transaction.new("amount" => 6.80, "tag_id"=>@tag_1.id, "merchant_id"=>@merchant_1.id)
    @transaction_1.save()

    @transaction_2 = Transaction.new("amount" => 5.40, "tag_id"=>@tag_1.id, "merchant_id"=>@merchant_1.id)
    @transaction_2.save()

    @transaction_3 = Transaction.new("amount" => 7.80, "tag_id"=>@tag_2.id, "merchant_id"=>@merchant_2.id)
    @transaction_3.save()
  end

  def teardown
    Tag.delete_all
    Merchant.delete_all
    Transaction.delete_all
  end

  def test_amount_total
    assert_equal(20.00, Transaction.total) # actual uses database data
  end

  def test_get_tag
    assert_equal(@tag_2.id, @transaction_3.tag.id) # get trans 3 from table, tag method, id
    assert_equal("Clothes", @transaction_3.tag.name)
  end

  def test_get_merchant
    assert_equal(@merchant_1.id, @transaction_2.merchant.id)
    assert_equal("McDonalds", @transaction_2.merchant.name)
  end

end
