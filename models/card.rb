class Card
  attr_accessor :name, :values, :overall_comparison, :best_comparison

  def initialize(line)
    @overall_comparison = {w: 0, l: 0, e: 0}
    @best_comparison = {w: 0, l: 0, e: 0}

    @values = []
    line.split(',').each_with_index do |value, index|
      if index == 0
        @name = value.strip
      else
        @values << value.to_i
      end
    end
  end

  def win_rate(type, card_count)
    if type == :overall
      return @overall_comparison[:w] * 100 / (card_count-1)
    elsif type == :best
      return @best_comparison[:w] * 100 / (card_count-1)
    end
    nil
  end

  def best_value_index(categories)
    indices = []
    categories.each do |category|
      category.ranking.each_with_index do |card, j|
        if card.name == self.name
          indices << j
          break
        end
      end
    end
    indices.find_index(indices.min)
  end

  def compare_overall_to(card, categories_count)
    result = 0; (0..categories_count-1).each { |index| result += compare_value(card, index) }

    if result > 0
      overall_comparison[:w] += 1
      card.overall_comparison[:l] += 1
    elsif result < 0
      overall_comparison[:l] += 1
      card.overall_comparison[:w] += 1
    elsif result == 0
      overall_comparison[:e] += 1
      card.overall_comparison[:e] += 1
    end
  end

  def compare_best_value_to(card, categories)
    result = compare_value(card, best_value_index(categories))

    if result > 0
      best_comparison[:w] += 1
    elsif result < 0
      best_comparison[:l] += 1
    elsif result == 0
      best_comparison[:e] += 1
    end
  end

  def compare_value(card, index)
    self.values[index] > card.values[index] ? 1 : -1
  end
end