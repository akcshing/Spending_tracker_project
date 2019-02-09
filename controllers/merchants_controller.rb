require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
also_reload("../models/*")
require("pry")

get "/merchants" do
  @merchants = Merchant.all()
  erb (:"merchants/index")
end

get "/merchants/new" do
  erb (:"merchants/new")
end

post "/merchants" do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect to "/merchants"
end

get "/merchants/:id" do
  @merchant = Merchant.find(params["id"])
  @merchant_total = @merchant.total
  erb (:"merchants/show")
end

get "/merchants/:id/edit" do
  @merchant = Merchant.find(params["id"])
  erb(:"merchants/edit")
end

post "/merchants/:id" do
  merchant = Merchant.new(params)
  merchant.update
  redirect to "/merchants"
end

post "/merchants/:id/delete" do
  merchant = Merchant.find(params["id"])
  merchant.destroy
  redirect to "/merchants"
end
