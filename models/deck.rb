require_relative 'card'
require_relative 'category'

class Deck
  attr_accessor :name, :cards, :categories

  def initialize(name)
    @name = name
    @cards = []
    @categories = []
  end

  def import(file_path)
    line_number = 0
    file = File.open(file_path).read

    file.gsub!(/\r\n?/, "\n")
    file.each_line do |line|
      if line_number == 0
        line.split(',').map{ |s| s.strip }.each do |value|
          @categories << Category.new(value)
        end
      else
        @cards << Card.new(line)
      end
      line_number += 1
    end

    calculate_category_ranges
    calculate_category_rankings
    calculate_category_avg
    calculate_win_rates
  end

  def cards_by(sort_type)
    if sort_type == :overall
      return @cards.sort{ |c1, c2| c2.win_rate(:overall) <=> c1.win_rate(:overall) }
    elsif sort_type == :best
      return @cards.sort{ |c1, c2| c2.win_rate(:best) <=> c1.win_rate(:best) }
    end
    @cards
  end

  private

  def calculate_category_ranges
    @categories.each_with_index do |category, i|
      @cards.each do |card|
        category.min = card.values[i] if category.min > card.values[i]
        category.max = card.values[i] if category.max < card.values[i]
      end
    end
  end

  def calculate_category_rankings
    (0..@categories.length-1).each do |index|
      @categories[index].ranking = @cards.sort{ |c1, c2| c2.values[index] <=> c1.values[index] }
    end
  end

  def calculate_category_avg
    @categories.each_with_index do |category, index|
      avg = 0
      category.ranking.each do |card|
        avg += card.values[index]
      end
      category.avg = avg / category.ranking.length
    end
  end

  def calculate_win_rates
    (0..@cards.length-1).each do |i|
      (i..@cards.length-1).each do |j|
        next if i == j
        @cards[i].compare_overall_to @cards[j]
      end
    end

    (0..@cards.length-1).each do |i|
      (0..@cards.length-1).each do |j|
        next if i == j
        @cards[i].compare_best_value_to @cards[j], @categories
      end
    end
  end
end