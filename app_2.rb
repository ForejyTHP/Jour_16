require 'bundler'
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'


def perform



  print"                      d@b
  H@b                 ,H@@______________________________________________________
  H@@EEEEEEEEEEEEEEEEEEEH@@         BIENVENUE DANS LE BATTLE ROYALE            /
  H@@EEEEEEEEEEEEEEEEEEEH@@       Sois le dernier survivant, ou meurt !       /
  H@@EEEEEEEEEEEEEEEEEEEH@@___________________________________________________
  H@P                  `H@@
                        T@\n\n"

  puts "Quel est votre prenom, combattant ?"
  human_player = HumanPlayer.new(gets.chomp)
  player1 = Player.new("Josianne")
  player2 = Player.new("Jose")

  ary_ennemies = [player1, player2]

  while (human_player.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0))#Ici peut-etre mettre un each
    print "\n----------------------------------------------------------------------"
    print "\nQuelle action veux-tu effectuer #{human_player.name}?\n\na - chercher une meilleure arme\ns - chercher a se soigner\n\nattaquer un joueur en vue :\n0 - "
    player1.show_state
    print "1 - "
    player2.show_state
    print "\n> "
    choix = gets.chomp
    while (choix !~ /[as01]/) #Si le choix est incorrect, continue de demander
      print "Mauvais choix, concentre toi !\n> "
      choix = gets.chomp
    end
    if choix == 'a' #Tour du joueur
      human_player.search_weapon
    elsif choix == 's'
      human_player.search_health_pack
    elsif choix == '0' && player1.life_points > 0
      human_player.attacks(player1)
    elsif choix == '1' && player2.life_points > 0
      human_player.attacks(player2)
    elsif (player1.life_points <= 0 && choix == '0') || (player2.life_points <= 0 && choix == '1')
      puts "On n'attaque pas un mort, vous perdez un tour !"
    end
    sleep(1)
    puts "\n\nLes autres joueurs t'attaquent !"
    ary_ennemies.each do |ennemy|
      if ennemy.life_points > 0 && human_player.life_points > 0
        ennemy.attacks(human_player)
      end
    end
    human_player.show_state
    sleep(1)
  end

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

perform