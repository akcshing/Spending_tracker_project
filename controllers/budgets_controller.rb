require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require_relative("../models/budget.rb")
also_reload("../models/*")
require("pry")

get "/budgets" do
  @overall_budget = Budget.find(1)
  @tags = Budget.tags
  erb (:"budgets/index")
end

get "/budgets/new" do
  erb (:"budgets/new")
end

post "/budgets" do
  @budget = Budget.new(params)
  @budget.save
  redirect to "/budgets"
end

get "/budgets/:id" do
  @budget = Budget.find(params["id"])
  erb (:"budgets/show")
end

get "/budgets/:id/edit" do
  @budget = Budget.find(params["id"])
  erb(:"budgets/edit")
end

post "/budgets/:id" do
  budget = Budget.new(params)
  budget.update
  redirect to "/budgets"
end

post "/budgets/:id/delete" do
  budget = Budget.find(params["id"])
  budget.destroy
  redirect to "/budgets"
end
