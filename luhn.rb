class Luhn

  attr_accessor :num, :ary, :create

  def initialize (num)
    self.num = num
  end

  def addends(remainder=1)
    new_ary = num_to_ary
    new_ary = new_ary.reverse
    new_ary.each_with_index do |element, idx|
      new_ary[idx] *= 2 if idx % 2 == remainder
      new_ary[idx] -= 9 if new_ary[idx] >= 10
    end
    new_ary.reverse
  end

  def checksum(create=nil)
    self.ary = num_to_ary
    if !create
      addends.reduce(:+)
    else
      addends(0).reduce(:+)
    end
  end

  def valid?
    if checksum % 10 == 0
      true
    else
      false
    end
  end

  def num_to_ary
    self.ary = num.to_s.split("").map { |s| s = s.to_i }
  end

  def self.create(num)
    luhn = Luhn.new(num)
    if !luhn.valid?
      new_num = 10 - (luhn.checksum(true) % 10)
      new_num = 0 if new_num == 10
      luhn.num_to_ary.push(new_num).join('').to_i
    else
      num
    end
  end

end
