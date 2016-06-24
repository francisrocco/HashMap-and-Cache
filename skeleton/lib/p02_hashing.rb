class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_val = length

    self.each_with_index do |el, idx|
      hash_val = hash_val ^ (el.hash * idx)
    end

    hash_val
  end
end

class String
  def hash

    chars.map(&:ord).hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.sort.hash ^ "hash".hash
  end
end
