A String object in Ruby holds and manipulates an arbitrary sequence of one or more bytes, typically representing characters that represent human language.
The simplest string literals are enclosed in single quotes


Expression Substitution:-
Expression substitution is a means of embedding the value of any Ruby expression into a string using #{ and }
Example:
x, y, z = 12, 36, 72
puts "The value of x is #{ x }."
puts "The sum of x and y is #{ x + y }."
puts "The average was #{ (x + y + z)/3 }."

Output:
The value of x is 12.
The sum of x and y is 48.
The average was 40.


STRING METHODS::

1) str.length
It returns the number of characters in string

Example:
str = "Hello, World!"
puts str.length  

Output: 13


2) str.empty?
It returns true if the number of characters in string is zero

Example:
str = ""
puts str.empty?  

Output: true


3) str.count()
It counts how many times a specific character is repeated     # This method is case sensitive

Example:
str = "hello"
puts str.count("l")  

Output: 2


4) str.insert(index, "")
It insert the given characters before the given index

Example:
str = "Hello"
str.insert(1, "ey")
puts str  

Output: "Heyello"


5) str.upcase / str.downcase
It transform all the letters of the string in uppercase and downcase

Example:
str = "Hello"
puts str.upcase        # Output: "HELLO"
puts str.downcase      # Output: "hello"


6) str.swapcase
It transform the uppercase letter to downcase and downcase letter to uppercase

Example:
str = "Hello"
puts str.swapcase   

Output: "hELLO"


7) str.captialize
It transform the first letter of string in uppercase and rest of the letters in downcase

Example:
str = "hello WORLD"
puts str.capitalize  

Output: "Hello world"


8) str.reverse
It reverse the order of characters in string

Example:
str = "Hello"
puts str.reverse  

Output: "olleH"


9) str.split
It split the string into an array and returns the array

Example:
str = "Hello, World!"
puts str.split(" ")  

Output: ["Hello,", "World!"]


10) str.chop
It removes the last character of the string and returns the new string and (str.chop!) this mutates the original string

Example:
str = "Hello"
puts str.chop  

Output: "Hell"


11) str.strip
It removes the extra spaces in string (\t, \r, \n)

Example:
str = "  Hello, World!  "
puts str.strip  

Output: "Hello, World!"


12) str.chomp
It removes the last character if it is a carriage return or a new line  # This method is commonly used with gets command

Example:
str = "Hello\n"
puts str.chomp  

Output: "Hello"


13) str.to_i , str.to_r
It coverts a string to integer and rational number

Example:
str = "123"
puts str.to_i  # Output: 123
puts str.to_r  # Output: (123/1)


14) str.gsub("" , "")
It replace the first parameter of the string with second parameter   # First parameter can also be a regular expression

Example:
str = "Hello, World!"
puts str.gsub("World", "Ruby")  

Output: "Hello, Ruby!"


15) str.concat, "" + "", "" << ""
It to concatenate two strings together

Example:
str1 = "Hello"
str2 = "World"
puts str1.concat(" ", str2)  # Output: "Hello World"
puts "Hello" + " World"      # Output: "Hello World"
str = "Hello"
str << " World"
puts str                    # Output: "Hello World"


16) str.index() , str.rindex()
It gives the index of the first and last occurence of the substring

Example:
str = "Hello, World!"
puts str.index("o")    # Output: 4
puts str.rindex("o")   # Output: 8


17) str.clear
It removes the content of the string

Example:
str = "Hello"
str.clear
puts str  

Output: ""


18) str.start_with? , str.end_with?
It returns true if the string is starting and ending with the given substring

Example:
str = "Hello, World!"
puts str.start_with?("Hello")  # Output: true
puts str.end_with?("World!")   # Output: true


19) str.succ
It returns the successor of self string

Example:
str = "abc"
puts str.succ  

Output: "abd"


20) str.to_c , str.to_f
It converts the string into complex or floating point number

Example:
str = "3.14"
puts str.to_f  # Output: 3.14
str = "2+3i"
puts str.to_c  # Output: (2+3i)


21) str.scan()
It returns an array of characters which is present from given condition

Example:
str = "abc123"
puts str.scan(/\d+/)  

Output: ["123"]


22) str.char
It returns an array of all characters given in string

Example:
str = "Hello"
puts str.chars  

Output: ["H", "e", "l", "l", "o"]


23) str.slice()
It remove the substring from the given string

Example:
str = "Hello, World!"
puts str.slice(7, 5)  

Output: "World"


24) str%arg
It is used to do modulus (arg must be array)

Example:
str = "Hello, %s!"
puts str % ["World"]  

Output: 
"Hello, World!"


25) str*arg
It repeats string a specified number of times.

Example:
str = "Hello"
puts str * 3  

Output:
"HelloHelloHello"


26) str+other_str
It concatenates two strings.

Example:
str1 = "Hello"
str2 = "World"
puts str1 + " " + str2  

Output: 
"Hello World"


27) str << obj
It concatenates an object to a string.
str = "Hello"
str << " World"
puts str  

Output: 
"Hello World"


28) str <=> other_str
Compares str with other_str, returning -1 (less than), 0 (equal), or 1 (greater than) [The comparison is case-sensitive].

Example:
puts "abc" <=> "def"        # Output: -1
puts "abc" <=> "abc"        # Output: 0
puts "def" <=> "abc"        # Output: 1


29) str == obj
Tests str and obj for equality. If obj is a String, returns true, otherwise false.

Example:
puts "abc" == "abc"  # Output: true
puts "abc" == "def"  # Output: false


30) str =~ obj
Matches str against a regular expression pattern obj. 
Returns the position where the match starts; otherwise, false.

Example:
puts "hello" =~ /e/  # Output: 1
puts "hello" =~ /z/  # Output: nil


31) str.b
Returns a copy of self that has ASCII-8BIT encoding

Example:
str = "Hello"
puts str.b.encoding 

Output: 
ASCII-8BIT


32) str.bytes
Returns the ASCII bits for each character

Example:
str = "Hello"
puts str.bytes  

Output: 
[72, 101, 108, 108, 111]


33) str.bytesize
Returns the total number of bytes in the string.

Example:
str = "Hello"
puts str.bytesize  

Output: 
5


34) str.byteslice(x)
Returns the byte present at the xth position

Example:
str = "Hello"
puts str.byteslice(1)  

Output: 
"e"


35) str.byteslice(x, n)
Returns n characters from the position of the xth byte

Example:
str = "Hello"
puts str.byteslice(1, 2)  

Output: 
"el"


36) str.bytesplice(x, n, 'a')
Replaces what the above returned with 'a'.

Example:
str = "Hello"
str.bytesplice(1, 2, "a")
puts str  

Output: 
"Hallo"


37) str.byteindex('character')
Returns the position of the character mentioned.

Example:
str = "Hello"
puts str.byteindex('e')  

Output: 
1


38) str.byterindex('char', x)
Returns the position where the character occurs for the xth time.

Example:
str = "Hello"
puts str.byterindex('l', 2)  

Output: 
3


39) str.casecmp
Makes a case-insensitive comparison of strings

Example:
puts "abc".casecmp("ABC")  

Output: 
0


40) str.center(size, pad_string = ' ')
Centers a string within the size mentioned with the character mentioned in the pad string

Example:
str = "Hello"
puts str.center(11, '-')  

Output: 
"---Hello---"


41) str.chomp!
Same as str.chomp, but changes are made in place.

Example:
str = "Hello\n"
str.chomp!
puts str  

Output: 
"Hello"


42) str.chop!
Same as str.chop, but changes are made in place.

Example:
str = "Hello"
str.chop!
puts str  

Output: 
"Hell"


43) str.concat(other_str)
Concatenates other_str to str

Example:
str = "Hello"
str.concat(" World")
puts str  

Output: 
"Hello World"


44) str.crypt(other_str)
Applies a one-way cryptographic hash to str. The argument is the salt string

Example:
str = "password"
puts str.crypt("aa")  

Output: 
a hashed password string


45) str.delete(x)
Returns a copy of str with all characters specified deleted.

Example:
str = "Hello, World!"
puts str.delete("l")  

Output: 
"Heo, Word!"


46) str.delete!(x)
Same as str.delete, but changes are made in place.

Example:
str = "Hello, World!"
str.delete!("l")
puts str  

Output: 
"Heo, Word!"


47) str.delete_prefix(prefix)
Removes the prefix mentioned and displays the remaining content of the string

Example:
str = "Hello, World!"
puts str.delete_prefix("Hello, ")  

Output: 
"World!"


48) str.delete_prefix!(prefix)
Does the same as above if the prefix exists, otherwise returns nil.

Example:
str = "Hello, World!"
str.delete_prefix!("Hello, ")
puts str  

Output: 
"World!"


49) str.delete_suffix(suffix)
Removes the suffix mentioned and displays the remaining content of the string.

Example:
str = "Hello, World!"
puts str.delete_suffix(", World!")  

Output: 
"Hello"


50) str.delete_suffix!(suffix)
Does the same as above if the suffix exists, otherwise returns nil.

Example:
str = "Hello, World!"
str.delete_suffix!(", World!")
puts str  

Output: 
"Hello"


51) str.downcase!
Same as str.downcase, but changes are made in place.

Example:
str = "Hello"
str.downcase!
puts str  

Output: 
"hello"


52) str.dump
Returns a version of str with all nonprinting characters replaced by \nnn notation and all special characters escaped.

Example:
str = "Hello\nWorld"
puts str.dump  

Output: 
"\"Hello\\nWorld\""


53) str.eql?('string')
Checks if str is equal to the string mentioned in the bracket.

Example:
str = "Hello"
puts str.eql?("Hello")  

Output: 
true


54) str.each_byte { |byte| print byte, ' ' }
Gives ASCII code for each character in the string along with the string.

Example:
str = "Hello"
str.each_byte { |byte| print byte, ' ' }  

Output: 
72 101 108 108 111 


55) str.each_char { |c| print c, ' ' }
Calls the given block with each successive character from self; returns self

Example:
str = "Hello"
str.each_char { |c| print c, ' ' }  

Output:
H e l l o 


56) str.encoding
Returns the Encoding object that represents the encoding of obj

Example:
str = "Hello"
puts str.encoding  

Output: 
UTF-8


57) str.force_encoding(type)
Changes the encoding of the string to the type mentioned.

Example:
str = "Hello"
str.force_encoding("ASCII-8BIT")
puts str.encoding  

Output: 
ASCII-8BIT


58) str.freeze
Makes the string immutable

Example:
str = "Hello"
str.freeze

# str << " World"  # This will raise an error


59) str.getbyte(n)
Returns the nth byte as an integer.

Example:
str = "Hello"
puts str.getbyte(1)  

Output: 
101


60) str.hex
Treats leading characters from str as a string of hexadecimal digits (with an optional sign) and returns the corresponding number.

Example:
str = "1a"
puts str.hex  

Output:
26


61) str.include?('substring')
Returns true if str contains the given string or character.

Example:
str = "Hello"
puts str.include?("ell")  

Output: 
true


62) str.initialize_copy
Copies the string to another variable.

Example:
str1 = "Hello"
str2 = str1.dup
puts str2  

Output: 
"Hello"


63) str.inspect
Returns a printable version of str, surrounded by quote marks, with special characters escaped.

Example:
str = "Hello\nWorld"
puts str.inspect  

Output: 
"\"Hello\\nWorld\""


64) str.intern
Same as to_sym.

Example:
str = "symbol"
puts str.intern  

Output:
 :symbol


66) str.ljust(n, 'pad_string')
Left-justifies str in a field of width n. Pads the string with pad_string until it is n characters long.

Example:
str = "Hello"
puts str.ljust(10, '-')  

Output: 
"Hello-----"


67) str.lstrip
Returns a copy of str with leading whitespace removed.

Example:
str = "   Hello"
puts str.lstrip  

Output: 
"Hello"


68) str.lstrip!
Removes leading whitespace from str. Returns nil if no change was made.

Example:
str = "   Hello"
str.lstrip!
puts str  

Output: 
"Hello"


69) str.next
Returns the successor to str. 
The successor is calculated by incrementing characters and digits within the string.

Example:
str = "abc"
puts str.next  

Output: 
"abd"


70) str.next!
Same as next, but changes are made in place.

Example:
str = "abc"
str.next!
puts str  

Output: 
"abd"


71) str.oct
Treats leading characters of str as a string of octal digits (with an optional sign) and returns the corresponding number.

Example:
str = "10"
puts str.oct  

Output: 8


72) str.ord
Returns the codepoint of the first character in the string.

Example:
str = "A"
puts str.ord  

Output: 65


73) str.partition(sep)
Divides str into three parts: the part before sep, sep itself, and the part after sep. If sep is not found, returns [str, "", ""].

Example:
str = "Hello World"
puts str.partition(" ")  

Output: 
["Hello", " ", "World"]


74) str.prepend(prefix)
Prepend adds prefix to str.

Example:
str = "World"
str.prepend("Hello ")
puts str  

Output: 
"Hello World"


75) str.rjust(n, pad_string=' ')
Right-justifies str in a field of width n. 
Pads the string with pad_string until it is n characters long.

Example:
str = "Hello"
puts str.rjust(10, '-')  

Output: 
"-----Hello"


76) str.rpartition(sep)
Same as partition, but searches for sep from the end of the string.

Example:
str = "Hello World"
puts str.rpartition(" ")  

Output: 
["Hello", " ", "World"]


77) str.rstrip
Returns a copy of str with trailing whitespace removed.

Example:
str = "Hello   "
puts str.rstrip  

Output: "Hello"


78) str.scan(/regex/) { |match| block }
Splits str based on the pattern and calls the block with each match.

Example:
str = "Hello123World456"
str.scan(/\d+/) { |match| puts match }  

Output: "123" "456"


79) str.setbyte(index, integer)
Modifies the index position with the integer provided.

Example:
str = "Hello"
str.setbyte(1, 97)
puts str  

Output: "Hallo"


80) str.size
Returns the character length of str.

Example:
str = "Hello"
puts str.size  

Output: 5


81) str.slice!(x, n)
Removes n characters from the xth position.

Example:
str = "Hello"
str.slice!(1, 3)
puts str  

Output: "Ho"


82) str.squeeze('chars')
Returns a new string where runs of the same character that occur in this set are replaced by a single character.

Example:
str = "HHeelloo"
puts str.squeeze("e")  

Output: "HHello"


83) str.sub(/pattern/, replacement)
Returns a copy of str with the first occurrence of pattern replaced by replacement.

Example:
str = "Hello World"
puts str.sub(/World/, "Ruby")  

Output: 
"Hello Ruby"


84) str.sum
Returns a basic n-bit checksum of the characters in str, where n is the optional integer parameter.

Example:
str = "Hello"
puts str.sum  

Output: 500


85) str.upto(limit, exclusive=false) { |str| block }
Iterates through successive values, starting at str and ending at the value of limit.

Example:
str = "a"
str.upto("e") { |s| print s, ' ' }  

Output: "a b c d e"


86) str.valid_encoding?
Returns true if str is a valid sequence of characters in its current encoding.

Example:
str = "Hello"
puts str.valid_encoding?  

Output: true


87) str.gsub!(/pattern/, replacement)
Same as gsub, but changes are made in place.

Example:
str = "Hello World"
str.gsub!(/World/, "Ruby")
puts str  

Output: "Hello Ruby"


88) str.match(/pattern/)
Matches the string against a pattern.

Example:
str = "Hello World"
puts str.match(/World/)[0]  

Output: "World"


89) str.hash
Returns the hash value of the string.

Example:
str = "Hello"
puts str.hash  

Output: (a unique hash value for the string)
-2312086633523929043


90) new
Creates a new instance of the string class.

Example:
str = String.new("Hello")
puts str  

Output: "Hello"

