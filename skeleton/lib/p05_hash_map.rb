require_relative 'p02_hashing'
require_relative 'p03_hash_set'
require_relative 'p04_linked_list'

class HashMap < HashSet

  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket_for(key)
    bucket.include?(key)
  end

  def set(key, val)
    bucket = bucket_for(key)
    link = bucket.get_link(key)
    if link
      link.val = val
    else
      resize! if @count == @store.length
      bucket.insert(key, val)
      @count += 1
    end
  end
  
  def get(key)
    bucket = bucket_for(key) # hash occurs in super
    bucket.get(key)
  end

  def delete(key)
    bucket = bucket_for(key)
    @count -= 1 if bucket.remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        yield(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def resize!
    old_store = @store
    @store = Array.new(old_store.size * 2) { LinkedList.new }

    old_store.each do |bucket|
      bucket.each do |link|
        bucket_for(link.key).insert(link.key, link.val)
      end
    end

  end

end
