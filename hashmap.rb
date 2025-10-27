class HashMap
  def initialize(load_factor, capacity)
    @load_factor = load_factor
    @capacity = capacity
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # Resizes the hash map to the new capacity and rehashes all entries
  def resize(new_capacity)
    old_entries = entries

    # Update capacity and create new buckets
    @capacity = new_capacity
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    # Rehash all entries into the new bucket array
    old_entries.each do |key, value|
      index = hash(key) % @capacity
      raise IndexError if index.negative? || index >= @buckets.length

      @buckets[index] << [key, value]
      @size += 1
    end
  end

  # Sets a new key, value pair in the hash map.
  # If a key already exists, the old value is overwritten.
  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]

    # Check if the key already exists
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    # Check if we need to resize
    resize(@capacity * 2) if (@size + 1).to_f / @capacity > @load_factor

    # Recalculate index in case we resized
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]
    bucket << [key, value]
    @size += 1
  end

  # Returns the value that is assigned to the given key.
  # If the key is not found, return nil.
  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  # Returns true or false depending on if the given key exists in
  # the hash map.
  def has?(key)
   index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]

    bucket.any? { |pair| pair[0] == key }
  end

  # If the given key is in the hash map, remove it and return the deleted
  # keys value. If the key is not in the hash map, return nil.
  def remove(key)
   index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      if pair[0] == key
        @size -= 1
        return bucket.delete_at(i)[1]
      end
    end

    nil
  end

  # Return the number of stored keys in the hash map.
  def length
    @size
  end

  # Remove all entries in the hash map.
  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # Return an array containing all the keys in the hash map.
  def keys
    keys_array = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        keys_array << pair[0]
      end
    end

    keys_array
  end

  # Return an array containing all the values in the hash map.
  def values
    values_array = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        values_array << pair[1]
      end
    end

    values_array
  end

  # Return an array that contains all the key, value pairs.
  # E.g: [[first_key, first_value], [second_key, second_value]]
  def entries
    entries_array = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        entries_array << pair
      end
    end

    entries_array
  end
end
