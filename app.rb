require_relative 'models/deck'
require_relative 'models/card'
require 'sinatra'

get '/analyze_dc' do
  @deck = Deck.new('DC Blue')
  @deck.import('resources/sample_deck.txt')
  erb :analyze
end

get '/analyze_souls' do
  @deck = Deck.new('Souls')
  @deck.import('resources/souls.txt')
  erb :analyze
end