# puts "Hello, Nishchay Gupta." 

# END {
#    puts "Completed Ruby Learning!"
# }

# BEGIN {
#    puts "This is Ruby Learning!"
# }

# I am a comment. Just ignore me.

=begin
This is a comment.
This is a comment, too.
This is a comment, too.
I said that already.
=end

# Tring Sring Methods :-

str = "Hello, World!"
puts str.length
puts str.empty?
puts str.count("l") 
str.insert(1, "ey")
puts str
puts str.upcase
puts str.downcase 
puts str.swapcase  
puts str.capitalize
puts str.reverse 
puts str.split(" ")
puts str.chop
puts str.strip  
str1="1234nishchay"
puts str1.to_i  
puts str1.to_r 
puts str.gsub("World", "Ruby") 
str << " Ruby"
puts str 
puts str.index("o")    
puts str.rindex("o")   
puts str.succ 
puts str.start_with?("Hello")  
puts str.end_with?("Ruby")  
# str.clear
# puts str  
puts str.to_f  
puts str.to_c
puts str.chars
# str = "Hello, World!"
puts str.slice(7, 5) 
str = "abc123"

puts str.scan(/\d+/)


arr = [1, 2, 3, 4]
puts arr[0]    
puts arr.at(0)    