require_relative '../models/deck'
require_relative '../models/card'

deck = Deck.new('DC Blue')
deck.import('resources/sample_deck.txt')

puts "#{deck.categories.map{ |c| c.to_s }.join(', ')}\n\n"
deck.cards_by(:overall).each do |card|
  puts card.to_s(deck.categories)
end