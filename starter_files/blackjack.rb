require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/hand'

class BlackjackGame
  attr_accessor :run

  def initialize
    @deck = Deck.new
    @wallet = 100
  end

  def player_name
    puts 'What is your name?'
    input = gets.chomp
    @name = input
  end

  def hit
    @hand.player_hand << @deck.draw
    puts "Your new hand is #{@hand.cards} which is #{@hand.total}"
  end

  def stand
    puts "You stand. Your hand is #{@hand.cards} which is #{@hand.total}"
  end


  # def play(input)
  #   input = gets.chomp
  #   puts "Your wallet has #{@wallet} would you like to bet $10 and play? (y)es or (n)o"
  #   if input.downcase[0] == 'y'
  #     BlackjackGame.run
  #   elsif input.downcase[0] == 'n'
  #     return
  #   else
  #     puts 'That is not a valid response'
  #   end
  # end
 
 
  def keep_playing
    input = ''
    puts 'Would you like to play again? (y)es or (n)o'
    input = gets
    while input.downcase[0] == 'y'
      round
    end
  end

  def round
    Deck.new
    @deck.shuffle
    @hand = Hand.new
    deal
    puts "The cards you have are #{@hand.cards} which is #{@hand.total}"
    hit_loop
  end

  def run
    puts 'Hello! Lets play blackjack!'
    player_name
    puts "Welcome #{@name}! Your wallet starts with $100 and you bet $10 each hand."
    round
    keep_playing
  end

  def deal
    2.times do
      @hand.player_hand << @deck.draw
    end
  end

  def wallet_lose
    @wallet -= 10
  end
  def wallet_win
    @wallet += 10
  end
  def hit_loop
    hit_answer = ''
    while hit_answer.downcase[0] != 's'
      if !@hand.busted?
        puts 'Would you like to (h)it or (s)tand?'
        hit_answer = gets
        if hit_answer.downcase[0] == 'h'
          hit
        else
          stand
          return
        end
      else
        wallet_lose
        puts 'You busted!'
        puts "#{@wallet}"
        return
      end
    end
  end
end

BlackjackGame.new.run
