require "bundler"
Bundler.require

require "pry"

require_relative "lib/game"
require_relative "lib/player"

test = Game.new("Wolverine")

binding.pry
