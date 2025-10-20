require_relative 'hashmap'

map = HashMap.new
map.set('apple', 'red')
map.set('banana', 'yellow')
map.set('apple', 'green')
p map
