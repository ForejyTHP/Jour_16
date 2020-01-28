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
  game = Game.new(gets.chomp)
  while (game.is_still_ongoing?)
    game.show_players
    # sleep(1)
    game.new_players_in_sight
    # sleep(2)
    game.menu
    choice = gets.chomp#TODO: Tester directement dans les parentheses
    while (choice !~ /[asZ01]/) #Si le choix est incorrect, continue de demander
      print "Mauvais choix, concentre toi !\n> "
      choice = gets.chomp
    end
    game.menu_choice(choice)
    sleep(1)
    game.enemies_in_sight_attack
    sleep(2)
  end
  game.end
end

perform
