class Sieve
  attr_accessor :primes

  def initialize(limit)
    range = create_range(limit)
    self.primes = [2]
    limit.times do
      range = range.select { |x| x % primes.last != 0 }
      primes.push(range.first) if range.first != nil
    end
  end

  def create_range(limit)
    (2..limit).to_a
  end

  def remove_multiple(prime, range)
    range.select { |x| x % prime  == 0 }
  end

end
