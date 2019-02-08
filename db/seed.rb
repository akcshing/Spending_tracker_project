require_relative("../models/merchant")
require("pry")

merchant_1 = Merchant.new({ "name"=>"McDonalds" })

# merchant_1.save

tag_1 = Tag.new({"name" => "Food"})

tag_1.save
transaction_1 = Transaction.new({})
binding.pry
nil
