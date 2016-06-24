class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @offset = 0
  end

  def [](i)
    @store[translate_index(i)]
  end

  def []=(i, val)
    @store[translate_index(i)] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    if @count == capacity
      #double
    end
    @store[translate_index(@count)] = val
    @count += 1
  end

  def unshift(val)
    if @count == capacity
      #double
    end
    @store[translate_index(-1)] = val
    @count += 1
  end

  def pop
    if @count == capacity / 4
      #halve
    end
    @store[translate_index(@count - 1)] = nil
    @count -= 1
  end

  def shift
    if @count == capacity / 4
      #halve
    end
    @store[translate_index(0)] = nil
    @count -= 1
    @offset += 1
  end

  def first
    @store[translate_index(0)]
  end

  def last
    @store[translate_index(@count - 1)]
  end

  def each
    


  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def translate_index(i)
    (i + @offset) % capacity
  end

  def resize!
  end
end
