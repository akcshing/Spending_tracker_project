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

# binding.pry
# nil
