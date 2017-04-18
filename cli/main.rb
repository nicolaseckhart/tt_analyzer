require_relative '../models/deck'
require_relative '../models/card'

def tabs(card)
  if card.name.length < 7
    "\t\t\t"
  elsif card.name.length > 14
    "\t"
  else
    "\t\t"
  end
end

deck = Deck.new('DC Blue')
deck.import('resources/souls.txt')

puts "#{deck.categories.map{ |c| c.to_s }.join(', ')}\n\n"
deck.cards_by(:overall).each do |card|
  puts "#{card.name}:#{tabs(card)}(#{card.values.join(', ')}) \tWin Rate overall: #{card.win_rate(:overall, deck.cards.length)}% (W/L/E: #{card.overall_comparison[:w]}, #{card.overall_comparison[:l]}, #{card.overall_comparison[:e]})  \tWin Rate best: #{card.win_rate(:best, deck.cards.length)}% (W/L/E: #{card.best_comparison[:w]}, #{card.best_comparison[:l]}, #{card.best_comparison[:e]}) [#{deck.categories[card.best_value_index(deck.categories)].name}]"
end