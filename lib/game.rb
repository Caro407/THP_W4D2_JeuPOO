class Game
  attr_accessor :human_player, :enemies

  def initialize(hero_name)
    @enemies = []
    4.times do |index_enemy|
      enemy = Player.new("enemy#{index_enemy + 1}")
      @enemies << enemy
    end
    @human_player = HumanPlayer.new(hero_name)
  end

  def kill_player(enemy_killed) # Cette méthode s'appelle sur une Game.
    @enemies.each_with_index do |enemy, index|
      @enemies.delete_at(index) if enemy == enemy_killed
    end
    return @enemies
  end

  def is_still_ongoing? # Cette méthode s'appelle sur une Game.
    @enemies.any? { |enemy| enemy.life_points > 0 } && @human_player.life_points > 0
  end

  def show_players # Cette méthode s'appelle sur une Game.
    remaining_life = @human_player.life_points
    remaining_bots = @enemies.length

    @enemies.each do |enemy|
      remaining_bots -= 1 if enemy.life_points <= 0
    end
    puts "Il te reste #{remaining_life} points de vie et #{remaining_bots} ennemis à tuer ! Haut les coeurs !"
    return remaining_bots
  end

  def show_menu(enemies) # Cette méthode prend en entrée un tableau.
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "\n"
    puts "attaquer un joueur en vue :"
    enemies.each_with_index do |enemy, index_position|
      if enemy.life_points > 0
        puts "#{index_position} - #{enemy.name} a #{enemy.life_points} points de vie."
      else
        puts "#{index_position} - #{enemy.name} a été tué(e)."
      end
    end
  end

  def decide_action_menu(enemies) # Cette méthode prend en entrée un tableau.
    print "> "
    player_action = gets.chomp
    chosen_target = 0

    if player_action == "a"
      @human_player.search_weapon
    elsif player_action == "s"
      @human_player.search_health_pack
    elsif (0..3).include?(player_action.to_i)
      chosen_target = enemies[player_action.to_i]
      @human_player.attacks(chosen_target)
      self.kill_player(chosen_target) if chosen_target.life_points <= 0 #end?
    end
  end

  def attack_human_player(enemies)
    enemies.each do |enemy|
      enemy.attacks(@human_player)
    end
  end

  def end_game
    puts "La partie est finie !"
    puts "\n"

    if @human_player.life_points > 0
      puts "BRAVO #{@human_player.name} ! Tu as gagné !!"
    else
      @human_player.life_points <= 0
      puts "Loseeeer ! Tu as perdu !"
    end
  end
end
