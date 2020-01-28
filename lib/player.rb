class Player
  attr_accessor :name
  attr_accessor :life_points

  def initialize(name_to_save)
    @name = name_to_save
    @life_points = 10
  end

  def show_state
    if @life_points > 0
       puts "#{@name} a #{@life_points} points de vie"
    else
       puts "#{@name} est mort"
    end
  end

  def gets_damage(damage)
    @life_points -= damage
    if @life_points <= 0
      puts " | Le joueur #{@name} a ete tue !"
    end
  end

  def attacks(player_to_attack)
    puts " | Le joueur #{@name} attaque le joueur #{player_to_attack.name}"
    dmg_computed = compute_damage
    puts " | Il lui inflige #{dmg_computed} points de dommages"
    player_to_attack.gets_damage(dmg_computed)
    return player_to_attack
  end



  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level
  attr_accessor :la_grosse_attaque_est_disponible

  def initialize(name_to_save)
    super(name_to_save)
    @life_points = 100
    @weapon_level = 1
    @la_grosse_attaque_est_disponible = true
  end

  def show_state
    if @life_points > 0
      puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level} #{find_weapon_img}"
      puts " " + "_" * 100
      print "|" + "_" * (@life_points - 1) + "|" + "_" * (100 - @life_points)
      @life_points < 98 ? (puts "|") : (print "\n")
    else
      puts "#{@name} est mort\n"
    end
  end

  def la_grosse_attaque(player_to_attack)
    puts " | Le joueur #{@name} attaque le joueur #{player_to_attack.name}"
    dmg_computed = @weapon_level * 2
    puts " | Il lui inflige #{dmg_computed} points de dommages"
    player_to_attack.gets_damage(dmg_computed)
    @la_grosse_attaque_est_disponible = false
    return player_to_attack
  end

  def find_weapon_img
    if @weapon_level == 1
      str_weapon = "-|----"
    elsif @weapon_level == 2
      str_weapon = "====)-------------"
    elsif @weapon_level == 3
      str_weapon = "
     #
O%%%%#============--
     #"
    elsif @weapon_level == 4
      str_weapon = "
      ./~
(=@@@@@@@=[}=================--
      `\_"
    elsif @weapon_level == 5
      str_weapon = "
        \\
 _      ||__________________
(_|%|%|%|[__________________>
        ||
         \\"
    elsif @weapon_level == 6
      str_weapon ="
            /\\
/vvvvvvvvvvvv \\--------------------------------------,
`^^^^^^^^^^^^ /=====================================\"
            \\/"
  end
end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouve une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends\n\n"
      @weapon_level = new_weapon_level
    else
      puts "M@*#\$... elle n'est pas mieux que ton arme actuelle...\n\n"
    end
  end

  def search_health_pack
    val = rand(1..6)
    if (val <= 1)
      puts "Tu n'as rien trouve...\n"
    elsif (val >= 2 && val <= 5)
      puts "Bravo, tu as trouve un pack de +50 points de vie !\n"
      @life_points < 50 ? @life_points += 50 : @life_points = 100
      puts "Tu as maintenant #{@life_points} points de vie\n"
    else
      puts "Waow, tu as trouve un pack de +80 points de vie !\n"
      @life_points < 20 ? @life_points += 80 : @life_points = 100
      puts "Tu as maintenant #{@life_points} points de vie\n"
    end
  end
end