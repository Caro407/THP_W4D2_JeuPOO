class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{self.name} a #{self.life_points} points de vie.\n\n"
  end

  def gets_damage(nb_of_damage_taken)
    @life_points = self.life_points - nb_of_damage_taken #Quelle est la différence ici entre @lp & self.hp ?
    if @life_points <= 0
      puts "Le joueur #{self.name} a été tué !"
    else
      self.show_state
    end
  end

  def attacks(player_attacked)
    puts "Le joueur #{self.name} attaque le joueur #{player_attacked.name}."
    damage_dealt = compute_damage
    puts "#{self.name} inflige #{damage_dealt} points de dommage à #{player_attacked.name} !"
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
    @life_points = 100
    @weapon_level = 1
    super(name)
  end

  def show_state # Pourquoi ça marche sans que j'ai besoin de mettre un "super" ?
    puts "#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}.\n\n"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Une arme de niveau #{new_weapon_level} a été trouvée par #{self.name}"
    if new_weapon_level > self.weapon_level
        @weapon_level = new_weapon_level
    else
        puts "Cette arme n'est pas meilleure que celle que le joueur possède déjà. Il vaut mieux ne pas en changer."
    end
  end

  def search_health_pack
  end
end
