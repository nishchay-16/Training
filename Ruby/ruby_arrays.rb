Ruby arrays are ordered, integer-indexed collections of any object. 
Each element in an array is associated with and referred to by an index.
Array indexing starts at 0, as in C or Java

# Creating Arrays
A new array can be created by using the literal constructor []. Arrays can contain different types of objects.
Example:
The array below contains an Integer, a String and a Float:
    ary = [1, "two", 3.0] 

There are many ways to create or initialize an array:-
*  One way is with the new class method
        names = Array.new

*  You can set the size of an array at the time of creating array 
        names = Array.new(20)

*  You can assign a value to each element in the array
        names = Array.new(4, "mac")

*  You can also use a block with new, populating each element with what the block evaluates 
        nums = Array.new(10) { |e| e = e * 2 }



AS WE SEE THERE ARE SO MANY WAYS , SO LETS DISCUSS ALL THE METHODS OF ARRAYS:-

# Array Methods:-

1. arr[0] 
   arr.at(0)
   arr.value_at()

These are used for accessing elements of array
Example:
arr = [1, 2, 3, 4]
puts arr[0]        # Output: 1
puts arr.at(0)     # Output: 1


2. arr.first
   arr.last

It gives the firts and last element of array
Example:
arr = [1, 2, 3, 4]
puts arr.first     # Output: 1
puts arr.last      # Output: 4


3. arr.take(n)

It gives the first n elements of array
Example:
arr = [1, 2, 3, 4]
puts arr.take(2)   # Output: [1, 2]


4. arr.drop(n)

It deletes the first n elements of the array
Example:
arr = [1, 2, 3, 4]
puts arr.drop(2)   # Output: [3, 4]


5. arr.count
   arr.length 
   arr.size

It gives the size of array
Example:
arr = [1, 2, 3, 4]
puts arr.count     # Output: 4
puts arr.length    # Output: 4
puts arr.size      # Output: 4


6. arr.empty?

It check whether array contains elements or not
Example;
arr = []
puts arr.empty?    # Output: true


7. arr.inlude?()

It check whether the particular element is present or not
Example:
arr = [1, 2, 3, 4]
puts arr.include?(2)  # Output: true


8. arr.push()
   arr<<
   arr.append

It put the element at the last of the array
Example:
arr = [1, 2, 3]
arr.push(4)
arr << 5
arr.append(6)
puts arr           # Output: [1, 2, 3, 4, 5, 6]


9. arr.unshift

It insert the element at the begining of the array
Example;
arr = [2, 3, 4]
arr.unshift(1)
puts arr           # Output: [1, 2, 3, 4]


10. arr.insert(index, '')

It insert the element at the given index
Example:
arr = [1, 2, 4, 5]
arr.insert(2, 3)
puts arr           # Output: [1, 2, 3, 4, 5]


11. arr.pop

It removes the last element of the array and returns it
Example:
arr = [1, 2, 3, 4]
arr.pop
puts arr           # Output: [1, 2, 3]


12. arr.delete_at()
It delete element at particular index
Example:
arr = [1, 2, 3, 4]
arr.delete_at(2)
puts arr           # Output: [1, 2, 4]


13. arr.shift

It permanently remove the first element of the array and returns it
Example:
arr = [1, 2, 3, 4]
arr.shift
puts arr           # Output: [2, 3, 4]


14. arr.uniq

It remove the duplicate eleement from the array
Example:
arr = [1, 2, 2, 3, 3, 4]
arr.uniq!
puts arr           # Output: [1, 2, 3, 4]


15. arr.reverse

It reverse the array
Example:
arr = [1, 2, 3, 4]
arr.reverse!
puts arr           # Output: [4, 3, 2, 1]


16. arr.each {|a| print a___,""}

It print the array according to the operation
Example:
arr = [1, 2, 3, 4]
arr.each {|a| print a, " "}
# Output: 1 2 3 4


17. arr.select{|a| cond} / arr.keep_if{}

It select elements according to the condition
Example:
arr = [1, 2, 3, 4]
selected = arr.select {|a| a.even?}
puts selected      # Output: [2, 4]

arr.keep_if {|a| a.even?}
puts arr           # Output: [2, 4]


18. arr.reject{|a| cond} / arr.delete_if{}

It reject elements according to the condition
Example:
arr = [1, 2, 3, 4]
rejected = arr.reject {|a| a.even?}
puts rejected      # Output: [1, 3]

arr.delete_if {|a| a.even?}
puts arr           # Output: [1, 3]


19. arr.index, arr.find_index

It gives the index of the particular element
Example:
arr = [1, 2, 3, 4]
puts arr.index(3)  # Output: 2


20. arr.max, arr.min

It gives the maximum and minumum values among all elements of array
Example:
arr = [1, 2, 3, 4]
puts arr.max       # Output: 4
puts arr.min       # Output: 1


21. arr.sample 

It gives one or more random elements
Example:
arr = [1, 2, 3, 4]
puts arr.sample    # Output: random element from arr


22. arr.shuffle

It return elements in random order
Example:
arr = [1, 2, 3, 4]
puts arr.shuffle   # Output: elements in random order


23. arr.intersection()

It returns the common elements found in the given arrays
Example:
arr1 = [1, 2, 3]
arr2 = [2, 3, 4]
puts arr1 & arr2   # Output: [2, 3]


24. arr.union() 
    arr.concat()

It combines the elements of given arrays
Example:
arr1 = [1, 2, 3]
arr2 = [4, 5, 6]
puts arr1 | arr2        # Output: [1, 2, 3, 4, 5, 6]
puts arr1.concat(arr2)  # Output: [1, 2, 3, 4, 5, 6]


25. arr.difference()

It returns the elements from self array which are not present in given array
Example:
arr1 = [1, 2, 3, 4]
arr2 = [2, 3]
puts arr1 - arr2   # Output: [1, 4]


26. arr.inspect
    arr.to_s

It converts the elements of the array to string
Example:
arr = [1, 2, 3]
puts arr.inspect   # Output: "[1, 2, 3]"
puts arr.to_s      # Output: "1, 2, 3"


27. arr.to_a

It returns a new array containing all its elements
Example:
arr = [1, 2, 3]
puts arr.to_a      # Output: [1, 2, 3]


28. arr.to_h

It returns a new hash formed from the elements
Example:
arr = [[:key1, 'value1'], [:key2, 'value2']]
hash = arr.to_h
puts hash          # Output: {:key1=>"value1", :key2=>"value2"}


29. arr.delete()

It delete the specific element
Example:
arr = [1, 2, 3, 4]
arr.delete(3)
puts arr           # Output: [1, 2, 4]


30. arr.join()

It join the elements of the array with the specific parameter
Example:
arr = [1, 2, 3]
puts arr.join(", ")# Output: "1, 2, 3"


31. arr.map{}

It iterates over each element of array and perform action on them
Example:
arr = [1, 2, 3]
mapped = arr.map {|a| a * 2}
puts mapped        # Output: [2, 4, 6]


32. arr.compact

It Remove nil elements from the array.
Example;
arr = [1, nil, 2, nil, 3]
arr.compact!
puts arr           # Output: [1, 2, 3]


33. arr.flatten

It converts a nested array into a single array.
Example:
arr = [1, [2, 3], [4, [5, 6]]]
arr.flatten!
puts arr           # Output: [1, 2, 3, 4, 5, 6]


34. arr.fill

It fill the array with a specified value.
Example:
arr = [1, 2, 3, 4]
arr.fill(0)
puts arr           # Output: [0, 0, 0, 0]


35. arr.zip

It Combine elements from multiple arrays into an array of arrays.
Example:
arr1 = [1, 2, 3]
arr2 = [4, 5, 6]
puts arr1.zip(arr2)  # Output: [[1, 4], [2, 5], [3, 6]]


36. arr.rotate

It rotate the elements of the array.
Example:
arr = [1, 2, 3, 4]
puts arr.rotate     # Output: [2, 3, 4, 1]
puts arr.rotate(2)  # Output: [3, 4, 1, 2]


37. arr.bsearch

It use binary search to find a specific element.
Example:
arr = [1, 2, 3, 4, 5, 6]
puts arr.bsearch {|x| x >= 4}  # Output: 4


38. arr.sort

It sort the elements of the array.
Example:
arr = [3, 1, 4, 2]
puts arr.sort       # Output: [1, 2, 3, 4]


39. arr.cycle(n)

It Iterate over the array n times.
Example:
arr = [1, 2, 3]
arr.cycle(2) {|x| puts x}
# Output: 1 2 3 1 2 3


40. arr.drop_while

Remove elements while the condition is true, and stop when it becomes false.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.drop_while {|x| x < 3}  # Output: [3, 4, 5]


41. arr.sort_by(& )

It sort the elements by a specified method.
Example:
arr = ["apple", "pear", "banana"]
puts arr.sort_by(&:length)  # Output: ["pear", "apple", "banana"]


42. arr.transpose

It transpose the rows and columns of an array.
Example:
arr = [[1, 2], [3, 4], [5, 6]]
puts arr.transpose  # Output: [[1, 3, 5], [2, 4, 6]]


43. arr.slice(index, length)

It remove a subarray starting at index and continuing for length elements.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.slice!(1, 3) # Output: [2, 3, 4]
puts arr              # Output: [1, 5]


44. arr.fetch(index, default)

It retrieve an element by index, returning a default value if the index is out of bounds.
Example:
arr = [1, 2, 3]
puts arr.fetch(5, 'not found')   # Output: not found


45. arr.permutation(n)

It return all permutations of n elements.
Example:
arr = [1, 2, 3]
puts arr.permutation(2).to_a   # Output: [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]]



# ----------------------------------------------------------------------------------------------
Array Methods From Ruby Documentation 
https://docs.ruby-lang.org/en/3.3/Array.html


1) Methods for Creating an Array

::[] -> Returns a new array populated with given objects.
Example:
array = Array[1, 2, 3]
puts array.inspect    # => [1, 2, 3]

::new -> Returns a new array.
Example:
array = Array.new
puts array.inspect    # => []

::try_convert -> Returns a new array created from a given object.
Example:
array = Array.try_convert([1, 2, 3])
puts array.inspect    # => [1, 2, 3]


2) Methods for Querying

length, size -> Returns the count of elements.
Example:
arr = [1, 2, 3]
arr.length
# => 3
arr.size
# => 3


include? -> Returns whether any element == a given object.
Example:
arr = [1, 2, 3]
arr.include?(2)
# => true

empty? -> Returns whether there are no elements.
Example:
arr = []
arr.empty?
# => true

all? -> Returns whether all elements meet a given criterion.
Example:
arr = [1, 2, 3]
arr.all? { |x| x > 0 }
# => true

any? -> Returns whether any element meets a given criterion.
Example:
arr = [1, 2, 3]
arr.any? { |x| x > 2 }
# => true

none? -> Returns whether no element == a given object.
Example:
arr = [1, 2, 3]
arr.none? { |x| x > 3 }
# => true

one? -> Returns whether exactly one element == a given object.
Example:
arr = [1, 2, 3]
arr.one? { |x| x == 2 }
# => true

count -> Returns the count of elements that meet a given criterion.
Example:
arr = [1, 2, 3, 2]
arr.count(2)
# => 2

find_index, index -> Returns the index of the first element that meets a given criterion.
Example:
arr = [1, 2, 3]
arr.find_index { |x| x == 2 }
# => 1
arr.index(2)
# => 1

rindex -> Returns the index of the last element that meets a given criterion.
Example:
arr = [1, 2, 3, 2]
arr.rindex(2)
# => 3

hash -> Returns the integer hash code.
Example:
arr = [1, 2, 3]
arr.hash


3) Methods for Comparing

<=> -> Returns -1, 0, or 1 * as self is less than, equal to, or greater than a given object.
Example:
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr3 = [1, 2, 4]
puts arr1 <=> arr2  # Output: 0 (equal)
puts arr1 <=> arr3  # Output: -1 (less than)
puts arr3 <=> arr1  # Output: 1 (greater than)

== -> Returns whether each element in self is == to the corresponding element in a given object.
Example:
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr3 = [1, 2, 4]
puts arr1 == arr2  # Output: true (elements are equal)
puts arr1 == arr3  # Output: false (elements are not equal)

eql? -> Returns whether each element in self is eql? to the corresponding element in a given object.
Example:
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr3 = [1, 2, 3.0]  # Note: 3.0 is a float
puts arr1.eql?(arr2)  # Output: true (elements are exactly equal)
puts arr1.eql?(arr3)  # Output: false (elements are not exactly equal due to type difference)


4) Methods for Fetching

[]: Returns one or more elements.
Example:
arr = [1, 2, 3, 4, 5]
puts arr[2]      # Output: 3
puts arr[1..3]   # Output: [2, 3, 4]

fetch: Returns the element at a given offset.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.fetch(2)         # Output: 3
puts arr.fetch(10, 'N/A') # Output: N/A

first: Returns one or more leading elements.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.first        # Output: 1
puts arr.first(3)     # Output: [1, 2, 3]

last: Returns one or more trailing elements.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.last         # Output: 5
puts arr.last(3)      # Output: [3, 4, 5]

max: Returns one or more maximum-valued elements, as determined by <=> or a given block.
Example:
arr = [1, 3, 2, 5, 4]
puts arr.max          # Output: 5
puts arr.max(2)       # Output: [5, 4]

min: Returns one or more minimum-valued elements, as determined by <=> or a given block.
Example:
arr = [1, 3, 2, 5, 4]
puts arr.min          # Output: 1
puts arr.min(2)       # Output: [1, 2]

minmax: Returns the minimum-valued and maximum-valued elements, as determined by <=> or a given block.
Example:
arr = [1, 3, 2, 5, 4]
puts arr.minmax       # Output: [1, 5]

assoc: Returns the first element that is an array whose first element == a given object.
Example:
arr = [[1, "one"], [2, "two"], [3, "three"]]
puts arr.assoc(2)     # Output: [2, "two"]

rassoc: Returns the first element that is an array whose second element == a given object.
Example:
arr = [[1, "one"], [2, "two"], [3, "three"]]
puts arr.rassoc("three")  # Output: [3, "three"]

at: Returns the element at a given offset.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.at(2)        # Output: 3

values_at: Returns the elements at given offsets.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.values_at(1, 3, 4)  # Output: [2, 4, 5]

dig: Returns the object in nested objects that is specified by a given index and additional arguments.
Example:
nested_arr = [[1, [2, 3]], [4, 5]]
puts nested_arr.dig(0, 1, 1)  # Output: 3

drop: Returns trailing elements as determined by a given index.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.drop(2)      # Output: [3, 4, 5]

take: Returns leading elements as determined by a given index.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.take(3)      # Output: [1, 2, 3]

drop_while: Returns trailing elements as determined by a given block.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.drop_while { |i| i < 3 }  # Output: [3, 4, 5]

take_while: Returns leading elements as determined by a given block.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.take_while { |i| i < 3 }  # Output: [1, 2]

slice: Returns consecutive elements as determined by a given argument.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.take_while { |i| i < 3 }  # Output: [1, 2]

sort: Returns all elements in an order determined by <=> or a given block.
Example:
arr = [5, 3, 4, 1, 2]
puts arr.sort         # Output: [1, 2, 3, 4, 5]

reverse: Returns all elements in reverse order.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.reverse      # Output: [5, 4, 3, 2, 1]

compact: Returns an array containing all non-nil elements.
Example:
arr = [1, nil, 3, nil, 5]
puts arr.compact      # Output: [1, 3, 5]

select, filter: Returns an array containing elements selected by a given block.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.select { |i| i.even? }  # Output: [2, 4]

uniq: Returns an array containing non-duplicate elements.
Example:
arr = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
puts arr.uniq         # Output: [1, 2, 3, 4]

rotate: Returns all elements with some rotated from one end to the other.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.rotate       # Output: [2, 3, 4, 5, 1]
puts arr.rotate(2)    # Output: [3, 4, 5, 1, 2]

bsearch: Returns an element selected via a binary search as determined by a given block.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.bsearch { |x| x >= 3 }  # Output: 3

bsearch_index: Returns the index of an element selected via a binary search as determined by a given block.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.bsearch_index { |x| x >= 3 }  # Output: 2

sample: Returns one or more random elements.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.sample       # Output: (a random element, e.g., 3)
puts arr.sample(3)    # Output: (three random elements, e.g., [2, 4, 5])

shuffle: Returns elements in a random order.
Example:
arr = [1, 2, 3, 4, 5]
puts arr.shuffle      # Output: (elements in random order, e.g., [3, 1, 5, 2, 4])


5) Methods for Assigning
These methods add, replace, or reorder elements in self.

[]=: Assigns specified elements with a given object.
push, append, <<: Appends trailing elements.
unshift, prepend: Prepends leading elements.
insert: Inserts given objects at a given offset; does not replace elements.
concat: Appends all elements from given arrays.
fill: Replaces specified elements with specified objects.
replace: Replaces the content of self with the content of a given array.
reverse!: Replaces self with its elements reversed.
rotate!: Replaces self with its elements rotated.
shuffle!: Replaces self with its elements in random order.
sort!: Replaces self with its elements sorted, as determined by <=> or a given block.
sort_by!: Replaces self with its elements sorted, as determined by a given block.


6) Methods for Deleting
Each of these methods removes elements from self:

pop: Removes and returns the last element.
shift: Removes and returns the first element.
compact!: Removes all nil elements.
delete: Removes elements equal to a given object.
delete_at: Removes the element at a given offset.
delete_if: Removes elements specified by a given block.
keep_if: Removes elements not specified by a given block.
reject!: Removes elements specified by a given block.
select!, filter!: Removes elements not specified by a given block.
slice!: Removes and returns a sequence of elements.
uniq!: Removes duplicates.


7) Methods for Combining

&: Returns an array containing elements found both in self and a given array.
intersection: Returns an array containing elements found both in self and in each given array.
+: Returns an array containing all elements of self followed by all elements of a given array.
-: Returns an array containing all elements of self that are not found in a given array.
|: Returns an array containing all elements of self and all elements of a given array, duplicates removed.
union: Returns an array containing all elements of self and all elements of given arrays, duplicates removed.
difference: Returns an array containing all elements of self that are not found in any of the given arrays..
product: Returns or yields all combinations of elements from self and given arrays.


8) Methods for Iterating

each: Passes each element to a given block.
reverse_each: Passes each element, in reverse order, to a given block.
each_index: Passes each element index to a given block.
cycle: Calls a given block with each element, then does so again, for a specified number of times, or forever.
combination: Calls a given block with combinations of elements of self; a combination does not use the same element more than once.
permutation: Calls a given block with permutations of elements of self; a permutation does not use the same element more than once.
repeated_combination: Calls a given block with combinations of elements of self; a combination may use the same element more than once.
repeated_permutation: Calls a given block with permutations of elements of self; a permutation may use the same element more than once.


9)Methods for Converting

map, collect: Returns an array containing the block return-value for each element.
map!, collect!: Replaces each element with a block return-value.
flatten: Returns an array that is a recursive flattening of self.
flatten!: Replaces each nested array in self with the elements from that array.
inspect, to_s: Returns a new String containing the elements.
join: Returns a newsString containing the elements joined by the field separator.
to_a: Returns self or a new array containing all elements.
to_ary: Returns self.
to_h: Returns a new hash formed from the elements.
transpose: Transposes self, which must be an array of arrays.
zip: Returns a new array of arrays containing self and given arrays; follow the link for details.
