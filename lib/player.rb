class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie.\n\n"
  end

  def gets_damage(nb_of_damage_taken)
    @life_points = @life_points - nb_of_damage_taken
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
    else
      self.show_state
    end
  end

  def attacks(player_attacked)
    puts "Le joueur #{@name} attaque le joueur #{player_attacked.name}."
    damage_dealt = compute_damage
    puts "#{@name} inflige #{damage_dealt} points de dommage à #{player_attacked.name} !"
    player_attacked.gets_damage(damage_dealt)
    puts "\n"
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}.\n\n"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Une arme de niveau #{new_weapon_level} a été trouvée par #{@name}"
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
    else
      puts "Cette arme n'est pas meilleure que celle que tu possèdes déjà. Il vaut mieux ne pas en changer."
    end
  end

  def search_health_pack
    research_result = rand(1..6)
    case research_result
    when 1
      puts "Tu n'as rien trouvé..."
    when (2..5)
      @life_points = @life_points + 50
      @life_points = 100 if @life_points > 100
      puts "Bravo, tu as trouvé un pack de +50 points de vie ! Tu as désormais #{@life_points}"
    when 6
      @life_points = @life_points + 80
      @life_points = 100 if @life_points > 100
      puts "WAOUH ! Tu as trouvé un giga pack de +80 points de vie !"
    end
  end

  def show_battle_menu(player_to_attack1, player_to_attack2)
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "\n"
    puts "attaquer un joueur en vue :"
    if player_to_attack1.life_points > 0
      puts "0 - #{player_to_attack1.name} a #{player_to_attack1.life_points} points de vie."
    else
      puts "0 - #{player_to_attack1.name} a été tué(e)."
    end
    if player_to_attack2.life_points > 0
      puts "1 - #{player_to_attack2.name} a #{player_to_attack2.life_points} points de vie."
    else
      puts "1 - #{player_to_attack2.name} a été tué(e)."
    end

    print '> '
    player_action = gets.chomp
    case player_action
    when "a"
      self.search_weapon
    when "s"
      self.search_health_pack
    when "0"
      self.attacks(player_to_attack1)
    when "1"
      self.attacks(player_to_attack2)
    end
  end
end
