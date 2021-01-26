require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

player1 = Player.new("Patrick")
player2 = Player.new("Orane")

puts "> Voici l'état des 2 joueurs :\n\n"
player1.show_state
player2.show_state

puts "> Passons à la phase d'attaque !\n\n"
while player1.life_points > 0 || player2.life_points > 0
  break unless player2.life_points > 0
  player2.attacks(player1)
  break unless player1.life_points > 0
  player1.attacks(player2)
end

binding.pry
