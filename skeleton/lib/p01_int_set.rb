require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max + 1, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket_for(num) << num unless include?(num)
  end

  def remove(num)
    bucket_for(num).delete(num)
  end

  def include?(num)
    bucket_for(num).include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def bucket_for(num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet < IntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @count = 0
    super
  end

  def insert(num)
    resize! if num_buckets == @count
    @count += 1
    super
  end

  def remove(num)
    @count -= 1
    super
  end

  private

  def resize!
    @store.concat( Array.new(count) { Array.new } )

    @count.times do |bucket_idx|
      @store[bucket_idx].each_index do
        update_bucket_for_first_element(bucket_idx)
      end
    end
  end

  def update_bucket_for_first_element(original_bucket_idx)
    num = @store[original_bucket_idx].shift
    bucket_for(num) << num
  end

end
