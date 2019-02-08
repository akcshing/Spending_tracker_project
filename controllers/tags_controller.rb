require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/tag.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
also_reload("../models/*")
require("pry")

get "/tags" do
  @tags = Tag.all()
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

get "/tags/:id" do
  @tag = Tag.find(params[:id])
  erb (:"tags/show")
end

get "/tags/:id/edit" do
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end

post "/tags/:id" do
  tag = Tag.new(params)
  tag.update
  redirect to "/tags"
end
