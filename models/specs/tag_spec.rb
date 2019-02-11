require("minitest/autorun")
require("minitest/rg")
require_relative("../transaction")
require_relative("../tag")
require_relative("../merchant")
require_relative("../budget")
require_relative("../../db/sqlrunner")
require("pry")

class TestTag < MiniTest::Test

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

  def test_get_transactions_of_tag
    assert_equal(2, @tag_1.transactions.count)
  end

  def test_get_tag_transactions_total
    assert_equal(12.20, @tag_1.total_spent)
  end

  def test_sort_tags_by_total
    assert_equal(@tag_1.id, Tag.sort_by_total.first.id)
  end

  def test_add_budget_to_tag
    @tag_1.add_budget()
  end

end

# binding.pry
# nil
