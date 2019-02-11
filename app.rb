require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/tags_controller.rb")
require_relative("controllers/merchants_controller.rb")
require_relative("controllers/transactions_controller.rb")
require_relative("controllers/budgets_controller.rb")
require_relative("models/transaction.rb")
also_reload("/models/*")
require("pry")

get "/" do
  @total = Transaction.total()
  erb (:index)
end
