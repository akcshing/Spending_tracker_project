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
  @total = Transaction.total

  erb (:"budgets/index")
end

get "/budgets/new" do
  @total = Transaction.total
  @tags = Budget.tags_no_budget
  erb (:"budgets/new")
end

post "/budgets" do
  @budget = Budget.new(params)
  @budget.save
  @tag = Tag.find(params["tag_id"])
  @tag.budget_id = @budget.id
  @tag.update()
    @overall_budget = Budget.find(1)
    @tags = Budget.tags
    @total = Transaction.total
    erb (:"budgets/index")
end

get "/budgets/overall/edit" do
  @total = Transaction.total
  erb (:"budgets/overall_edit")
end

get "/budgets/:id" do
  @total = Transaction.total
  @budget = Budget.find(params["id"])
  erb (:"budgets/show")
end

get "/budgets/:id/edit" do
  @total = Transaction.total
  @budget = Budget.find(params["id"])
  @tag = @budget.tag
  erb(:"budgets/edit")
end

post "/budgets/:id/delete" do
  budget = Budget.find(params["id"])
  tag = budget.tag    # removing relation
  tag.budget_id = nil
  tag.update()
  budget.destroy
  redirect to "/budgets"
end

post "/budgets/:id" do
  budget = Budget.new(params)
  budget.update
  redirect to "/budgets"
end
