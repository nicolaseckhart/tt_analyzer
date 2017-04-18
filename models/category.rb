class Category
  attr_accessor :name, :min, :max, :avg, :ranking

  def initialize(name)
    @name = name
    @min = 100000
    @max = 0
    @avg = 0
    @ranking = []
  end

  def to_s
    "#{@name} (#{@min} to #{@max}, avg: #{@avg})"
  end
end