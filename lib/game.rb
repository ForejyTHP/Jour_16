require_relative 'player'

class Game
  attr_accessor :human_player
  attr_accessor :enemies_in_sight
  attr_accessor :players_left

  def initialize(name_to_save)
    @human_player = HumanPlayer.new(name_to_save)
    @enemies_in_sight = []
    @players_left = 15
  end

  def kill_player(player_to_kill)
    @enemies_in_sight.delete(player_to_kill)
    @players_left -= 1
  end

  def is_still_ongoing?
    if human_player.life_points > 0 && players_left > 0
      return true
    else
      return false
    end
  end

  def show_players
    print "\n"
    human_player.show_state
    puts "Il reste #{@players_left} ennemis a tuer.\n"
  end

  def menu
    print "\n----------------------------------------------------------------------\nQuelle action veux-tu effectuer #{human_player.name}?\n\na - chercher une meilleure arme\ns - chercher a se soigner\n"
    if human_player.la_grosse_attaque_est_disponible == true
      print"Z - utiliser la grosse attaque"
    end

    print "\n\nattaquer un joueur en vue :\n"
    enemies_in_sight.each.with_index do |enemy, ind|
      print "#{ind} - "
      enemy.show_state
      end
    print "\n> "
  end

  def menu_choice(choice)#Tour du joueur principal
    if choice == 'a' 
      human_player.search_weapon
    elsif choice == 's'
      human_player.search_health_pack
    elsif choice == 'Z' && human_player.la_grosse_attaque_est_disponible
      survivors_ary = [] #Recreer une array pour garder les survivants, sinon ca bug
      @enemies_in_sight.each do |enemy|
        human_player.la_grosse_attaque(enemy)
        if enemy.life_points > 0
          survivors_ary.push(enemy)
        end
      end
      @enemies_in_sight = survivors_ary
    elsif enemies_in_sight.size > 0 #Le joueur principal attaque les autres joueurs
      interval = "[0-#{enemies_in_sight.size - 1}]";
      regexp = Regexp.new(interval,"g");
       if choice =~ regexp
        temp_enemy = @enemies_in_sight[choice.to_i]
        human_player.attacks(temp_enemy)
        if temp_enemy.life_points <= 0
          kill_player(temp_enemy)
          p "it's done"
        end
       end
    end
  end

  def enemies_in_sight_attack
    @enemies_in_sight.each do |enemy|
      if human_player.life_points > 0
        enemy.attacks(human_player)
      end
    end
  end

  def end
    puts "\n\nLa partie est finie"
    if (human_player.life_points > 0)
      puts "BRAVO ! TU AS GAGNE! MAIS QUEL GLADIATEUR !!!!"
    else
      puts "\n\n                   Quel loser ! Tu es mort !"
      puts "	
                          ____________
                        .~      ,   . ~.
                       /                \\
                      /      /~\\/~\\   ,  \\
                     |   .   \\    /   '   |
                     |         \\/         |
            XX       |  /~~\\        /~~\\  |       XX
          XX  X      | |  o  \\    /  o  | |      X  XX
        XX     X     |  \\____/    \\____/  |     X     XX
   XXXXX     XX      \\         /\\        ,/      XX     XXXXX
  X        XX%;;@      \\      /  \\     ,/      @%%;XX        X
  X       X  @%%;;@     |           '  |     @%%;;@  X       X
  X      X     @%%;;@   |. ` ; ; ; ;  ,|   @%%;;@     X      X
   X    X        @%%;;@                  @%%;;@        X    X
    X   X          @%%;;@              @%%;;@          X   X
     X  X            @%%;;@          @%%;;@            X  X
      XX X             @%%;;@      @%%;;@             X XX
        XXX              @%%;;@  @%%;;@              XXX
                           @%%;;%%;;@
                             @%%;;@
                           @%%;;@..@@
                            @@@  @@@
        "
    end
  end

  def new_players_in_sight
    puts "\nDe nouveaux ennemis peuvent arriver !"
    sleep(1)
    dice = rand(1..6)
    if dice >= 2 && dice <= 4 && @enemies_in_sight.size + 1 <= 10
      names = File.open("files/list_of_names.txt", "r").read.split("\n")
      @enemies_in_sight.push(Player.new(names[rand(0..names.size)]))
      puts "Un nouvel ennemi est arrive."
    elsif dice >= 5 && @enemies_in_sight.size + 2 <= 10
      names = File.open("files/list_of_names.txt", "r").read.split("\n")
      @enemies_in_sight.push(Player.new(names[rand(0..names.size)]))
      puts "2 nouveaux ennemis viennent d'arriver"
    else
      puts "Aucun nouvel ennemi n'est arrive."
    end
  end
end