require("pry")
require_relative("../db/sqlrunner.rb")

class Tag

  attr_accessor :id, :name

  def initialize( tag )
    @id = tag["id"].to_i if tag["id"]
    @name = tag["name"]
  end



end
