require 'bundler'
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("Jose")

puts("Bienvenue dans l'arene\n")
puts "Voici l'etat de chaque joueur : \n"
player1.show_state
player2.show_state
puts "\n\nQue le combat commence !"

while(player1.life_points > 0 && player2.life_points > 0)
    player1.attacks(player2)
  if (player2.life_points > 0)
    player2.attacks(player1)
  end
end










# binding pry
