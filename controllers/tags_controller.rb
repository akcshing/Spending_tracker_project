require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
also_reload("../models/*")
require("pry")

get "/tags" do
  @tags = Tag.sort_by_total
  erb (:"tags/index")
end

get "/tags/new" do
  erb (:"tags/new")
end

post "/tags" do
  @tag = Tag.new(params)
  @tag.save
  redirect to "/tags"
end

get "/tags/:id/newmerch" do
  @tag = Tag.find(params["id"])
  erb (:"tags/newmerch")
end

post "/tags/newmerch" do   # wow that worked?
  @merchant = Merchant.new(params)
  @merchant.save()
  Transaction.new({"tag_id"=>params["tag_id"], "merchant_id"=>@merchant.id}).save()
  @tag = Tag.find(params["tag_id"])
  @merchants = @tag.merchants.reverse
  erb (:"tags/newtrans")

  # redirect to "/tags/#{params["tag_id"]}/newtrans"   # REDIRECT TROUBLE
end

post "/tags/:id/newtrans" do
  transaction = Transaction.new(params)
  transaction.save()
  redirect to "/transactions"
end


get "/tags/:id" do
  @tag = Tag.find(params["id"])
  @tag_total = @tag.total
  erb (:"tags/show")
end

get "/tags/:id/edit" do
  @tag = Tag.find(params["id"])
  erb(:"tags/edit")
end

get "/tags/:id/newtrans" do
  @tag = Tag.find(params["id"])
  @merchants = @tag.merchants
  erb (:"tags/newtrans")
end



post "/tags/:id" do
  tag = Tag.new(params)
  tag.update
  redirect to "/tags"
end

post "/tags/:id/delete" do
  tag = Tag.find(params["id"])
  tag.destroy
  redirect to "/tags"
end
