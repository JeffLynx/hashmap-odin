# Learning hashes
# Use case: Organizing student names at a school
#
# Example: A hashing method that takes a name and
# a surname and gives us the first letter of both
# def hash(name, surname)
#  name[0] + surname[0]
# end

# hash('Carlos', 'Smith') => 'CS'
# But, lots of people might have these initials.
# This solves that:

# Note to self: #ord returns the numeric ASCII value of a string,
# in this case a single char.
def string_to_number(string)
  hash_code = 0
  prime_number = 31
  # Using this number we can generate different hash codes for different
  # combinations of the same letters.
  string.each_char { |char| hash_code = prime_number * hash_code + char.ord }
  hash_code
end

def hash(name, surname)
  string_to_number(name) + string_to_number(surname)
end
