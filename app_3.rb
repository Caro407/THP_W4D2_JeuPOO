require "bundler"
Bundler.require

require "pry"

require_relative "lib/game"
require_relative "lib/player"

# ---- INTRODUCTION VISUELLE DU JEU

puts "-" * 50
print "|"
print "BIENVENUE SUR LE JEU 'ILS VEULENT TOUS MA POO' !"
puts "|"
print "|"
print "Le but du jeu est d'être le dernier survivant ! "
puts "|"
puts "-" * 50

# ---- INITIALISATION DE LA PARTIE (JOUEUR ET ENNEMIS)

puts "Comment t'appelles-tu ?"
print "> "
user_name = gets.chomp

my_game = Game.new(user_name)

# ---- COMBAT

while my_game.is_still_ongoing?
    my_game.show_players
    my_game.show_menu(my_game.enemies)
    my_game.decide_action_menu(my_game.enemies)
    my_game.attack_human_player(my_game.enemies)
end

# ---- FIN DU JEU
my_game.end_game
