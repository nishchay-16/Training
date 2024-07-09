RUBY HASHES

Hash is a collection of unique keys and their values. 
Hash is like an Array, except the indexing is done with the help of arbitrary keys of any object type. 
In Hash, the order of returning keys and their value by various iterators is arbitrary and will generally not be in the insertion order. 
The default value of Hashes is nil. 
When a user tries to access the keys which do not exist in the hash, then the nil value is returned.



HASHES METHODS

* Methods for Creating a Hash

1) ::[] -> Returns a new hash populated with given objects.
Example:
hash = Hash["key1", "value1", "key2", "value2"]
# Result: {"key1"=>"value1", "key2"=>"value2"}

2) ::new -> Returns a new empty hash.
Example:
hash = Hash.new
# Result: {}

3)::try_convert -> Returns a new hash created from a given object.
Example:
obj = { "key" => "value" }
hash = Hash.try_convert(obj)
# Result: {"key"=>"value"}



* Methods for Setting Hash State

1) compare_by_identity -> Sets self to consider only identity in comparing keys.
Example:
a = "key"
b = "key"
hash = {}
hash[a] = "value1"
hash[b] = "value2"
puts hash
# Output: {"key"=>"value2"}     -----------------(a and b are considered the same key)
hash = {}.compare_by_identity
hash[a] = "value1"
hash[b] = "value2"
puts hash
# Output: {"key"=>"value1", "key"=>"value2"} ------------------(a and b are considered different keys)

2) default= -> Sets the default to a given value.
Example:
hash = Hash.new
hash.default = "default value"
puts hash[:non_existent_key]      # Output: "default value"
hash[:existing_key] = "specific value"
puts hash[:existing_key]          # Output: "specific value"

3) default_proc= -> Sets the default proc (lambda) to a given proc for the hash.
Example:
hash = Hash.new
hash.default_proc = ->(h, k) { h[k] = k * 2 }
puts hash[5]        # Output: 10 (hash is now {5=>10})
puts hash           # Output: {5=>10}
puts hash[7]        # Output: 14 (hash is now {5=>10, 7=>14})
puts hash           # Output: {5=>10, 7=>14}

4) rehash -> Rebuilds the hash table by recomputing the hash index for each key.
Example:
key = [1, 2]
hash = { key => "value" }
puts hash[key]     # Output: "value"
key[0] = 3
puts hash[key]     # Output: nil (key's hash value has changed)
hash.rehash
puts hash[key]     # Output: "value" (hash index recomputed)



* Methods for Querying

1) any? -> Returns whether any element satisfies a given criterion.
Example:
hash = { a: 1, b: 2, c: 3 }
result = hash.any? { |key, value| value > 2 }
puts result     # Output: true (since 3 is greater than 2)

2) compare_by_identity? -> Returns whether the hash considers only identity when comparing keys.
Example:
hash = {}.compare_by_identity
puts hash.compare_by_identity?     # Output: true
hash2 = {}
puts hash2.compare_by_identity?    # Output: false

3) default -> Returns the default value, or the default value for a given key.
Example:
hash = Hash.new("default value")
puts hash.default               # Output: "default value"
puts hash[:non_existent_key]    # Output: "default value"

4) default_proc -> Returns the default proc.
Example:
hash = Hash.new { |h, k| h[k] = k * 2 }
puts hash.default_proc     # Output: #<Proc:0x...> 
puts hash[5]               # Output: 10 
puts hash                  # Output: {5=>10}

5) empty? -> Returns whether there are no entries.
Example:
hash = {}
puts hash.empty?    # Output: true
hash[:key] = "value"
puts hash.empty?    # Output: false

6) eql? -> Returns whether a given object is equal to self.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { a: 1, b: 2 }
hash3 = { a: 1, b: 3 }
puts hash1.eql?(hash2)  # Output: true
puts hash1.eql?(hash3)  # Output: false

7) hash -> Returns the integer hash code.
Example:
hash = { a: 1, b: 2 }
puts hash.hash     # Output: Some integer (hash code)

8) has_value? -> Returns whether a given object is a value in self.
Example:
hash = { a: 1, b: 2 }
puts hash.has_value?(2)     # Output: true
puts hash.has_value?(3)     # Output: false

9) include?, has_key?, member?, key? -> Returns whether a given object is a key in self.
Example:
hash = { a: 1, b: 2 }
puts hash.include?(:a)    # Output: true
puts hash.has_key?(:b)    # Output: true
puts hash.member?(:c)     # Output: false
puts hash.key?(:d)        # Output: false

10) length, size -> Returns the count of entries.
Example:
hash = { a: 1, b: 2, c: 3 }
puts hash.length     # Output: 3
puts hash.size       # Output: 3

11) value? -> Returns whether a given object is a value in self.
Example:
hash = { a: 1, b: 2 }
puts hash.value?(2)     # Output: true
puts hash.value?(3)     # Output: false



* Methods for Comparing

1) #<    -> Returns whether self is a proper subset of a given object.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { a: 1, b: 2, c: 3 }
puts hash1 < hash2      # Output: true 
puts hash2 < hash1      # Output: false 

2) #<=   -> Returns whether self is a subset of a given object.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { a: 1, b: 2, c: 3 }
hash3 = { a: 1, b: 2 }
puts hash1 <= hash2      # Output: true 
puts hash1 <= hash3      # Output: true 
puts hash2 <= hash1      # Output: false 

3) ==    -> Returns whether a given object is equal to self.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { a: 1, b: 2 }
hash3 = { a: 1, b: 3 }
puts hash1 == hash2     # Output: true 
puts hash1 == hash3      # Output: false 

4) #>    -> Returns whether self is a proper superset of a given object
Example:
hash1 = { a: 1, b: 2, c: 3 }
hash2 = { a: 1, b: 2 }
puts hash1 > hash2     # Output: true 
puts hash2 > hash1     # Output: false 

5) #>=   -> Returns whether self is a superset of a given object.
hash1 = { a: 1, b: 2, c: 3 }
hash2 = { a: 1, b: 2 }
hash3 = { a: 1, b: 2, c: 3 }
puts hash1 >= hash2     # Output: true 
puts hash1 >= hash3     # Output: true 
puts hash2 >= hash1     # Output: false 



* Methods for Fetching

1) []  -> Returns the value associated with a given key.
Example:
hash = { a: 1, b: 2, c: 3 }
value = hash[:a]
puts value        # Output: 1

2) assoc  -> Returns a 2-element array containing a given key and its value.
Example: 
hash = { a: 1, b: 2, c: 3 }
result = hash.assoc(:b)
puts result.inspect     # Output: [:b, 2]

3) dig  -> Returns the object in nested objects that is specified by a given key and additional arguments.
Example:
hash = { a: { b: { c: 3 } } }
value = hash.dig(:a, :b, :c)
puts value            # Output: 3
value = hash.dig(:a, :x, :y)
puts value.inspect    # Output: nil

4) fetch  -> Returns the value for a given key.
Example:
hash = { a: 1, b: 2 }
value = hash.fetch(:a)
puts value            # Output: 1
begin
  hash.fetch(:c)
rescue KeyError => e
  puts e.message      # Output: key not found: :c
end

5) fetch_values -> Returns array containing the values associated with given keys.
Example:
hash = { a: 1, b: 2, c: 3 }
values = hash.fetch_values(:a, :c)
puts values.inspect      # Output: [1, 3]
begin
  hash.fetch_values(:a, :d)
rescue KeyError => e
  puts e.message         # Output: key not found: :d
end

6) key -> Returns the key for the first-found entry with a given value.
Example:
hash = { a: 1, b: 2, c: 1 }
key = hash.key(1)
puts key          # Output: :a
key = hash.key(3)
puts key.inspect  # Output: nil

7) keys -> Returns an array containing all keys in self.
Example;
hash = { a: 1, b: 2, c: 3 }
keys = hash.keys
puts keys.inspect     # Output: [:a, :b, :c]

8) rassoc -> Returns a 2-element array consisting of the key and value of the first-found entry having a given value.
Example:
hash = { a: 1, b: 2, c: 1 }
result = hash.rassoc(1)
puts result.inspect      # Output: [:a, 1]
result = hash.rassoc(3)
puts result.inspect      # Output: nil

9) values -> Returns an array containing all values in self
Example:
hash = { a: 1, b: 2, c: 3 }
values = hash.values
puts values.inspect     # Output: [1, 2, 3]  

10) values_at -> Returns an array containing values for given keys.
Example:
hash = { a: 1, b: 2, c: 3 }
values = hash.values_at(:a, :c)
puts values.inspect       # Output: [1, 3]
values = hash.values_at(:a, :d)
puts values.inspect       # Output: [1, nil]



* Methods for Assigning

1) []=, store -> Associates a given key with a given value.
Example:
hash = {}
hash[:a] = 1
hash.store(:b, 2)
puts hash.inspect     # Output: {:a=>1, :b=>2}

2) merge -> Returns the hash formed by merging each given hash into a copy of self.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { b: 3, c: 4 }
merged_hash = hash1.merge(hash2)
puts merged_hash.inspect     # Output: {:a=>1, :b=>3, :c=>4}
puts hash1.inspect           # Output: {:a=>1, :b=>2} 

3) merge!, update -> Merges each given hash into self.
Example: 
hash1 = { a: 1, b: 2 }
hash2 = { b: 3, c: 4 }
hash1.merge!(hash2)
puts hash1.inspect     # Output: {:a=>1, :b=>3, :c=>4} 
hash3 = { d: 5 }
hash1.update(hash3)
puts hash1.inspect     # Output: {:a=>1, :b=>3, :c=>4, :d=>5} 

4) replace -> Replaces the entire contents of self with the contents of a given hash.
Example:
hash1 = { a: 1, b: 2 }
hash2 = { c: 3, d: 4 }
hash1.replace(hash2)
puts hash1.inspect      # Output: {:c=>3, :d=>4} 



* Methods for Deleting
These methods remove entries from self :

1) clear -> Removes all entries from self.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.clear
puts hash.inspect       # Output: {}

2) compact! -> Removes all nil-valued entries from self.
Example:
hash = { a: 1, b: nil, c: 3 }
hash.compact!
puts hash.inspect       # Output: {:a=>1, :c=>3}

3) delete -> Removes the entry for a given key.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.delete(:b)
puts hash.inspect       # Output: {:a=>1, :c=>3}

4) delete_if -> Removes entries selected by a given block.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.delete_if { |key, value| value > 1 }
puts hash.inspect       # Output: {:a=>1}

5) filter!, select! -> Keep only those entries selected by a given block.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.select! { |key, value| value > 1 }
puts hash.inspect     # Output: {:b=>2, :c=>3}
hash.filter! { |key, value| value < 3 }
puts hash.inspect     # Output: {:b=>2}

6) keep_if -> Keep only those entries selected by a given block.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.keep_if { |key, value| value > 1 }
puts hash.inspect     # Output: {:b=>2, :c=>3}

7) reject! -> Removes entries selected by a given block.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.reject! { |key, value| value > 1 }
puts hash.inspect     # Output: {:a=>1}

8) shift -> Removes and returns the first entry. 
Example:
hash = { a: 1, b: 2, c: 3 }
entry = hash.shift
puts entry.inspect    # Output: [:a, 1]
puts hash.inspect     # Output: {:b=>2, :c=>3}

These methods return a copy of self with some entries removed :

9) compact -> Returns a copy of self with all nil-valued entries removed.
Example:
hash = { a: 1, b: nil, c: 3 }
new_hash = hash.compact
puts new_hash.inspect     # Output: {:a=>1, :c=>3}
puts hash.inspect         # Output: {:a=>1, :b=>nil, :c=>3}

10) except -> Returns a copy of self with entries removed for specified keys.
Example:
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.except(:b, :c)
puts new_hash.inspect      # Output: {:a=>1}
puts hash.inspect          # Output: {:a=>1, :b=>2, :c=>3}

11) filter, select -> Returns a copy of self with only those entries selected by a given block.
Example: 
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.select { |key, value| value > 1 }
puts new_hash.inspect      # Output: {:b=>2, :c=>3}
puts hash.inspect          # Output: {:a=>1, :b=>2, :c=>3}

new_hash = hash.filter { |key, value| value < 3 }
puts new_hash.inspect      # Output: {:a=>1, :b=>2}
puts hash.inspect          # Output: {:a=>1, :b=>2, :c=>3}

12) reject -> Returns a copy of self with entries removed as specified by a given block.
Example:
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.reject { |key, value| value > 1 }
puts new_hash.inspect     # Output: {:a=>1}
puts hash.inspect         # Output: {:a=>1, :b=>2, :c=>3}

13) slice -> Returns a hash containing the entries for given keys.
Example:
hash = { a: 1, b: 2, c: 3 }
sliced_hash = hash.slice(:a, :c)
puts sliced_hash.inspect    # Output: {:a=>1, :c=>3}
puts hash.inspect           # Output: {:a=>1, :b=>2, :c=>3}



* Methods for Iterating

1) each, each_pair -> Calls a given block with each key-value pair.
Example:
hash = { a: 1, b: 2, c: 3 }
# --------------------------------------Using each
hash.each do |key, value|
  puts "#{key}: #{value}"
end
# Output:
# a: 1
# b: 2
# c: 3
# --------------------------------------Using each_pair
hash.each_pair do |key, value|
  puts "#{key}: #{value}"
end
# Output:
# a: 1
# b: 2
# c: 3

2) each_key -> Calls a given block with each key.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.each_key do |key|
  puts key
end
# Output:
# a
# b
# c


3) each_value -> Calls a given block with each value.
Example:
hash = { a: 1, b: 2, c: 3 }
hash.each_value do |value|
  puts value
end
# Output:
# 1
# 2
# 3



* Methods for Converting

1) inspect, to_s -> Returns a new String containing the hash entries.
Example:
hash = { a: 1, b: 2, c: 3 }
puts hash.inspect      # Output: "{:a=>1, :b=>2, :c=>3}"
puts hash.to_s         # Output: "{:a=>1, :b=>2, :c=>3}"

2) to_a -> Returns a new array of 2-element arrays; each nested array contains a key-value pair from self.
Example:
hash = { a: 1, b: 2, c: 3 }
array = hash.to_a
puts array.inspect     # Output: [[:a, 1], [:b, 2], [:c, 3]]

3) to_h -> Returns self if a Hash; if a subclass of Hash, returns a Hash containing the entries from self.
Example:
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.to_h {|key, value| [value, key] }
puts new_hash      # Output:  {1=>:a, 2=>:b, 3=>:c} 

4) to_hash -> Returns self.
Example:
hash = { a: 1, b: 2, c: 3 }
same_hash = hash.to_hash
puts same_hash.equal?(hash)    # Output: true

5) to_proc -> Returns a proc that maps a given key to its value.
Example:
hash = { a: 1, b: 2, c: 3 }
proc = hash.to_proc
proc.class           # Output: Proc
puts proc.call(:a)   # Output: 1
puts proc.call(:b)   # Output: 2
puts proc.call(:z)   # Output: nil 



* Methods for Transforming Keys and Values

1) transform_keys -> Returns a copy of self with modified keys.
Example:
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.transform_keys { |key| key.to_s }
puts new_hash     # Output: {"a"=>1, "b"=>2, "c"=>3}

2) transform_keys! -> Modifies keys in self
Example:
hash = { a: 1, b: 2, c: 3 }
hash.transform_keys! { |key| key.to_s }
puts hash        # Output: {"a"=>1, "b"=>2, "c"=>3}

3) transform_values -> Returns a copy of self with modified values.
Example: 
hash = { a: 1, b: 2, c: 3 }
new_hash = hash.transform_values { |value| value * 2 }
puts new_hash     # Output: {:a=>2, :b=>4, :c=>6}

4) transform_values! -> Modifies values in self.
Example: 
hash = { a: 1, b: 2, c: 3 }
hash.transform_values! { |value| value * 2 }
puts hash        # Output: {:a=>2, :b=>4, :c=>6}



* Other Methods

1) flatten -> Returns an array that is a 1-dimensional flattening of self.
Example:
hash = { a: { b: { c: 1 } }, d: 2 }
flattened_array = hash.flatten
puts flattened_array        # Output: [:a, {:b=>{:c=>1}}, :d, 2]

2) invert -> Returns a hash with the each key-value pair inverted.
Example: 
hash = { a: 1, b: 2, c: 3 }
inverted_hash = hash.invert
puts inverted_hash           # Output: {1=>:a, 2=>:b, 3=>:c}
