require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

# ---- INTRODUCTION VISUELLE DU JEU

puts "-" * 50
print "|"
print "BIENVENUE SUR LE JEU 'ILS VEULENT TOUS MA POO' !"
puts "|"
print "|"
print "Le but du jeu est d'être le dernier survivant !"
puts "|"
puts "-" * 50

# ---- INITIALISATION DU JOUEUR

puts "Comment t'appelles-tu ?"
print "> "
user_name = gets.chomp
player1 = HumanPlayer.new(user_name)

# ---- INITIALISATION DES ENNEMIS
list_players = []

enemy1 = Player.new("Patrick")
list_players << enemy1
enemy2 = Player.new("Orane")
list_players << enemy2

# ---- COMBAT

while player1.life_points > 0 && (enemy1.life_points > 0 || enemy2.life_points > 0)
  player1.show_battle_menu(enemy1, enemy2)
  puts "C'est au tour des ennemis d'attaquer !"
  list_players.each do |enemy|
    enemy.attacks(player1) if enemy.life_points > 0
  end
end

# ---- FIN DU JEU
puts "La partie est finie !"
puts "\n"

if player1.life_points > 0
  puts "BRAVO ! Tu as gagné !!"
else
    player1.life_points <= 0
    puts "Loseeeer ! Tu as perdu !"
end
