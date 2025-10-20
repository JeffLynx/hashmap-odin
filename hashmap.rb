# For the hashmap project, this restriction should be used
# when accessing a bucket through an index to simulate real conditions:
#   raise IndexError if index.negative? || index >= @buckets.length

class HashMap
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # Sets a new key, value pair in the hash map.
  # If a key already exists, the old value is overwritten.
  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]

    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        break
      end
    end

    return if bucket.any? { |pair| pair[0] == key }

    bucket << [key, value]
  end

  # Returns the value that is assigned to the given key.
  # If the key is not found, return nil.
  def get(key)
  end

  # Returns true or false depending on if the given key exists in
  # the hash map.
  def has?(key)
  end

  # If the given key is in the hash map, remove it and return the deleted
  # keys value. If the key is not in the hash map, return nil.
  def remove(key)
  end

  # Return the number of stored keys in the hash map.
  def length
  end

  # Remove all entries in the hash map.
  def clear
  end

  # Return an array containing all the keys in the hash map.
  def keys
  end

  # Return an array containing all the values in the hash map.
  def values
  end

  # Return an array that contains all the key, value pairs.
  # E.g: [[first_key, first_value], [second_key, second_value]]
  def entries
  end
end
