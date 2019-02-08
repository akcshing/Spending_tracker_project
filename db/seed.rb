require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
require("pry")

merchant_1 = Merchant.new({ "name"=>"McDonalds" })

merchant_1.save()

merchant_1.name = "KFC"
merchant_1.update()


tag_1 = Tag.new({"name" => "Food"})

tag_1.save()
tag_1.name = "Grub"
tag_1.update()


transaction_1 = Transaction.new({"amount"=>5.80, "tag_id"=>tag_1.id, "merchant_id"=>merchant_1.id})

transaction_1.save()
transaction_1.amount = 9.50
transaction_1.update()


binding.pry
nil
