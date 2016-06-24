require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      link = @map[key]
      update_link!(link)
    else
      eject! if count == @max
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map[key] = @store.insert(key, val)
    val
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    link.delete_thyself
    @store.insert(link.key, link.val)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.delete_thyself
  end
end
