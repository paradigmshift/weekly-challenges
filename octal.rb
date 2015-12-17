class Octal
  attr_accessor :oct_ary

  def initialize(octal_str)
    oct = octal_str.to_i.abs
    begin
      self.oct_ary = split_to_ary(oct)
      # make sure no elements over the value of 7
      self.oct_ary.all? { |e| e < 8 } ? true : raise
    rescue
      self.oct_ary = [0]
    end
  end

  def split_to_ary(x)
    Math.log10(x).floor.downto(0).map { |i| (x / 10**i) % 10 }
  end

  def to_decimal
    oct_ary.reverse.each_with_index.map do |x, i|
      8**i * x
    end.reduce(:+)
  end
end
