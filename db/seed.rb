require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
require("pry")
#
# merchant_1 = Merchant.new({ "name"=>"McDonalds" })
# merchant_2 = Merchant.new({ "name"=>"UNIQLO"})
# merchant_3 = Merchant.new({ "name"=>"M&S"})
#
# merchant_1.save()
# merchant_1.name = "KFC"
# merchant_1.update()
#
# merchant_2.save()
# merchant_3.save()
#
# tag_1 = Tag.new({"name" => "Food"})
# tag_2 = Tag.new({"name" => "Clothes"})
#
# tag_1.save()
# tag_1.name = "Grub"
# tag_1.update()
#
# tag_2.save()
#
# transaction_1 = Transaction.new({"amount"=>5.80, "tag_id"=>tag_1.id, "merchant_id"=>merchant_1.id})
# transaction_2 = Transaction.new({"amount"=>26.00, "tag_id"=>tag_2.id, "merchant_id"=>merchant_2.id})
# transaction_3 = Transaction.new({"amount"=>16.00, "tag_id"=>tag_2.id, "merchant_id"=>merchant_3.id})
# transaction_4 = Transaction.new({"amount"=>4.50, "tag_id"=>tag_1.id, "merchant_id"=>merchant_3.id})
#
# transaction_1.save()
#
# transaction_1.amount = 9.50
# transaction_1.update()
#
#
# transaction_2.save()
# transaction_3.save()
# transaction_4.save()
#

binding.pry
nil

# Tag.find(2).destroy
