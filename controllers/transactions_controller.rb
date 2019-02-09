require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
also_reload("../models/*")
require("pry")

get "/transactions" do
  @transactions = Transaction.all()
  @transactions_total = Transaction.total()
  erb (:"transactions/index")
end

get "/transactions/new" do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb (:"transactions/new")
end

post "/transactions" do
  transaction = Transaction.new(params)
  transaction.save()
  redirect to "/transactions"
end

get "/transactions/:id" do
  @transaction = Transaction.find(params["id"])
  erb (:"transactions/show")
end

# binding.pry
# nil
