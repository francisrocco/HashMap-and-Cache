require_relative 'p02_hashing'
require_relative 'p01_int_set.rb'

class HashSet < ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    super
  end

  def insert(key)
    super(key.hash)
  end

  def include?(key)
    super(key.hash)
  end

  def remove(key)
    super(key.hash)
  end

  private

  def bucket_for(key)
    super(key.hash)
  end

end
