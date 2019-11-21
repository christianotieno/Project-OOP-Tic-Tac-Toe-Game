#!/usr/bin/env ruby
require "./lib/logic.rb"

def welcome
puts "Welcome to the TicTacToe Game"
end

def rules
puts "The rules..."
puts "The board is arranged in squares boxes which start from number 1 to 9. Player 1 will play crosses(X). Player 2 will play naughts(O).
You will have to choose on which position of the board you will place your choice. May the odds be ever in your favor :)"
puts ""
puts "Sample board containing numbered positions. "
puts "| 1 || 2 || 3 |"
puts "----+----+-----+"
puts "| 4 || 5 || 6 |"
puts "----+----+-----+"
puts "| 7 || 8 || 9 |"

puts " "
end

def get_player_names
  puts 'Player 1 kindly enter your name: '
  player1 = gets.chomp.capitalize!
  puts 'Player 2 kindly enter your name: '
  player2 = gets.chomp.capitalize!
  puts "Good to have you here #{player1} and #{player2}"
  players = [player1, player2]
  chosen_players = players.shuffle
  puts "#{chosen_players[0]} has randomly been selected as first player he will be using X"
  return chosen_players
end

def ask_move(current_player)
  puts "#{current_player}: Please input the position between 1 and 9 you wish to place your move "
end

def game_over_message(current_player)
  return "#{current_player} won!" if board.game_over? == :winner
  return 'The game ended in a draw' if board.game_over? == :draw
end

def check_input(input = nil)
  if !input.nil? 
    return true if input != 0 && input.is_a?(Numeric) && input.to_s.length != 0 && input.to_s.length == 1
  end
  return false
end


def switch_players(players, turn)
  if turn.odd?
   return players[0]
  else
   return players[1]
  end
end

def replay
puts 'Do you want a rematch? Press y for yes or n for no '
choice = gets.chomp
choice.downcase!
if choice != 'y' || choice != 'n' 
loop do
  choice = gets.chomp
  choice.downcase!
  if choice != 'y' || choice != 'n'
    puts 'Seems you entered the wrong input please press y for yes or n for no '
    next
  else
    break
  end
end
if choice == 'y'
  names = get_player_names
  game = TicTacToe::Game.new(names[0], names[1])
  play(game, names)
elsif choice == 'n'
  puts 'Glad to have you do come again :)'
end
end
end

def get_right_input
  loop do
    puts "Seems you entered the wrong input. Please choose a number from 1-9 :)"
    position = gets.chomp
    position = position.to_i
    break if check_input(position)
  end
  return position
end

def play(game, player)
  current_player = player[0]
  turn = 1
  arr = []
  loop do
    puts game.print_grid
    puts ''
    ask_move(current_player)
    position = gets.chomp
    position = position.to_i
    if !check_input(position)
      position = get_right_input
    end
    if arr.include?(position)
    puts "Position has already been taken"
    puts 'Positions filled with numbers are available so choose a number on the board'
    next
    end
    arr << position
    game.get_move(position, current_player)
    
    puts ''
    turn += 1
    if turn > 6
      if game.game_over?
        puts game.game_over_message(current_player)
        game.print_grid
        break
      end
    elsif turn > 9
      replay
    end
    current_player = switch_players(player, turn)
  end
  replay
end

welcome

names = get_player_names

game = TicTacToe::Game.new(names[0], names[1])

play(game, names)