Ruby is a scripting language designed by Yukihiro Matsumoto, also known as Matz. 
It runs on a variety of platforms, such as Windows, Mac OS, and the various versions of UNIX.

* Ruby is a pure object-oriented programming language.
* Ruby is an open-source and is freely available on the Web, but it is subject to a license.
* Ruby is a general-purpose, interpreted programming language.
* Ruby is a server-side scripting language similar to Python and PERL.
* Ruby can be used to write Common Gateway Interface (CGI) scripts.
* Ruby can be embedded into Hypertext Markup Language (HTML).
* Ruby has a clean and easy syntax that allows a new developer to learn very quickly and easily.
* Ruby is very much scalable and big programs written in Ruby are easily maintainable.
* Ruby has similar syntax to that of many programming languages such as C++ and Perl.
* Ruby can be used for developing Internet and intranet applications.
* Ruby can be installed in Windows and POSIX environments.
* Ruby can easily be connected to DB2, MySQL, Oracle, and Sybase.
* Ruby has a rich set of built-in functions, which can be used directly into Ruby scripts.
* Ruby support many GUI tools such as Tcl/Tk, GTK, and OpenGL.


FEATURES OF RUBY:-
Ruby has many reasons for being popular and in demand. Few of the reasons are mentioned below:
 
1) The code written in Ruby is small, elegant and powerful as it has fewer number of lines of code.
2) Ruby allows simple and fast creation of Web application which results in less hard work.
3) As Ruby is free of charge that is Ruby is free to copy, use, modify, it allow programmers to make necessary changes as and when required.
4) Ruby is a dynamic programming language due to which there is no tough rules on how to built in features and it is very close to spoken languages.

# Ruby BEGIN Statement
   Declares code to be called before the program is run.
   Syntax:  BEGIN {
                code
            }

        Example:    puts "Hello, Nishchay Gupta." 
                    BEGIN {
                        puts "This is Ruby Learning!"
                    }  

        Output: This is Ruby Learning!
                Hello, Nishchay Gupta.



# Ruby END Statement
    Declares code to be called at the end of the program.   
    Syntax: END {
                code
            }

        Example:    puts "Hello, Nishchay Gupta." 
                    END {
                        puts "Completed Ruby Learning!"
                    }

        Output: Hello, Nishchay Gupta.
                Completed Ruby Learning!



# Ruby Comments
    A comment hides a line, part of a line, or several lines from the Ruby interpreter.

    SingleLined:   # I am a comment. Just ignore me.

    MultiLined:   =begin
                  This is a comment.
                  This is a comment, too.
                  This is a comment, too.
                  I said that already.
                  =end  
    


# Variables
    There are different types of variables in Ruby:
				1) Local variables:
						- A local variable name always starts with a lowercase letter(a-z) or underscore (_). 
						- These variables are local to the code construct in which they are declared.
						- A local variable is only accessible within the block of its initialization. 
						- Local variables are not available outside the method. 
						- There is no need to initialize the local variables.
						Example: age = 10
										 _Age = 20


				2) Instance variables:
						- An instance variable name always starts with a @ sign. 
						- They are similar to Class variables but their values are local to specific instances of an object. 
						- Instance variables are available across methods for any specified instance or object i.e. instance variables can change from object to object.
						- There is no need to initialize the instance variables and uninitialized instance variable always contains a nil value.
						Example: 
							class Customer
   							def initialize(id, name, addr)
      						@cust_id = id
      						@cust_name = name
      						@cust_addr = addr
   							end
  						 def display_details()
      						puts "Customer id #@cust_id"
      						puts "Customer name #@cust_name"
      						puts "Customer address #@cust_addr"
   									end
								end

								cust1 = Customer.new("1", "John", "Wisdom Apartments, Ludhiya")
								cust2 = Customer.new("2", "Poul", "New Empire road, Khandala")

										cust1.display_details()
										cust2.display_details()


				3) Class variables:
						- A class variable name always starts with @@ sign.
						- It is available across different objects.
						- A class variable belongs to the class and it is a characteristic of a class. 
						- They need to be initialized before use.
						- Another way of thinking about class variables is as global variables within the context of a single class. 
						- A class variable is shared by all the descendants of the class. 
						- An uninitialized class variable will result in an error.
						Example: 
							class Customer 
								@@no_of_customers = 0

								def initialize(id, name, addr)  
									@cust_id = id 
									@cust_name = name 
									@cust_addr = addr 
								end
 
								def display_details() 
									puts "Customer id #@cust_id"
									puts "Customer name #@cust_name"
									puts "Customer address #@cust_addr"
								end

								def total_no_of_customers() 
									@@no_of_customers += 1
									puts "Total number of customers: #@@no_of_customers"
								end
							end

							cust1 = Customer.new("1", "John", "Wisdom Apartments, Ludhiya") 
							cust2 = Customer.new("2", "Poul", "New Empire road, Khandala") 

							cust1.display_details() 
							cust1.total_no_of_customers() 
							cust2.display_details() 
							cust2.total_no_of_customers() 


				4) Global variables :
						- A global variable name always starts with $. 
						- Class variables are not available across classes. 
						- If you want to have a single variable, which is available across classes, you need to define a global variable. 
						- Its scope is global, means it can be accessed from anywhere in a program. 
						- By default, an uninitialized global variable has a nil value and its use can cause the programs to be cryptic and complex.
						Example: 							
							$global_variable = 10
							class Class1 
								def print_global 
									puts "Global variable in Class1 is #$global_variable"
								end
							end
							class Class2 
								def print_global 
									puts "Global variable in Class2 is #$global_variable"
									end
								end
							class1obj = Class1.new
							class1obj.print_global 
							class2obj = Class2.new
							class2obj.print_global 



# Operators
	Ruby supports a rich set of operators, as you could expect from a modern language. 
	Most operators are actually method calls		

	1)  Arithmetic Operators:-

			a) + operator: (Addition) − Adds values on either side of the operator.
				 Example:- 	a + b will give 30

			b) - operator: (Subtraction0 − Subtracts right hand operand from left hand operand.
				 Example:- a - b will give -10	

			c) * operator: (Multiplication) − Multiplies values on either side of the operator.
				 Example:- a * b will give 200	

			d) / operator: (Division) − Divides left hand operand by right hand operand.
				 Example:- b / a will give 2

			e) % operator: (Modulus) − Divides left hand operand by right hand operand and returns remainder.
				 Example:- b % a will give 0	

			f) **	operator: (Exponent) − Performs exponential (power) calculation on operators. 					
				 Example:- a**b will give 10 to the power 20	


	2) Comparison Operators

 			a) == operator: Checks if the value of two operands are equal or not, if yes then condition becomes true.
				Example: (a == b) is not true.

			b) != operator: Checks if the value of two operands are equal or not, if values are not equal then condition becomes true.
				Example: (a != b) is true.

			c) > operator: Checks if the value of left operand is greater than the value of right operand, if yes then condition becomes true.
				Example: (a > b) is not true.

			d) < operator: Checks if the value of left operand is less than the value of right operand, if yes then condition becomes true.
				Example: (a < b) is true.

			e) >= operator: Checks if the value of left operand is greater than or equal to the value of right operand, if yes then condition becomes true.
				Example: (a >= b) is not true.

			f) <= operator: Checks if the value of left operand is less than or equal to the value of right operand, if yes then condition becomes true.
				Example: (a <= b) is true.

			g) <=> operator: Combined comparison operator. Returns 0 if first operand equals second, 1 if first operand is greater than the second and -1 if first operand is less than the second.
				Example: (a <=> b) returns -1.

			h) === operator: Used to test equality within a when clause of a case statement.
				Example: (1...10) === 5 returns true.

			i) .eql? operator: True if the receiver and argument have both the same type and equal values.
				Example: 1 == 1.0 returns true, but 1.eql?(1.0) is false.

			j) equal?	operator: True if the receiver and argument have the same object id.					
				Example: if aObj is duplicate of bObj then aObj == bObj is true, a.equal?bObj is false but a.equal?aObj is true.


	3) Assignment Operators

			a) = operator: (Simple assignment operator), assigns values from right side operands to left side operand.
				Example: c = a + b will assign the value of a + b into c

			b) += operator: (Add AND assignment operator) adds right operand to the left operand and assign the result to left operand.
				Example: 	c += a is equivalent to c = c + a
				
			c) -= operator: (Subtract AND assignment operator), subtracts right operand from the left operand and assign the result to left operand
				Example: c -= a is equivalent to c = c - a
				
			d) *= operator: (Multiply AND assignment operator), multiplies right operand with the left operand and assign the result to left operand.
				Example: c *= a is equivalent to c = c * a
				
			e) /= operator: (Divide AND assignment operator), divides left operand with the right operand and assign the result to left operand.
				Example: c /= a is equivalent to c = c / a
				
			f) %= operator: (Modulus AND assignment operator), takes modulus using two operands and assign the result to left operand.
				Example: c %= a is equivalent to c = c % a
			
			g) **= operator: (Exponent AND assignment operator), performs exponential (power) calculation on operators and assign value to the left operand.
				Example: c **= a is equivalent to c = c ** a


	4) Bitwise Operators

			a) & operator: 	(Binary AND Operator) copies a bit to the result if it exists in both operands.
				Example: (a & b) will give 12, which is 0000 1100
 
			b) | operator: (Binary OR Operator) copies a bit if it exists in either operand.
				Example: (a | b) will give 61, which is 0011 1101
 
			c) ^ operator: (Binary XOR Operator) copies the bit if it is set in one operand but not both.
				Example: (a ^ b) will give 49, which is 0011 0001
 
			d) ~ operator: (Binary Ones Complement Operator) is unary and has the effect of 'flipping' bits.
				Example: (~a ) will give -61, which is 1100 0011 in 2s complement form due to a signed binary number.
 
			e) << operator: (Binary Left Shift Operator). The left operands value is moved left by the number of bits specified by the right operand.
				Example: a << 2 will give 240, which is 1111 0000
 
			f) >> operator: (Binary Right Shift Operator). The left operands value is moved right by the number of bits specified by the right operand.
				Example: a >> 2 will give 15, which is 0000 1111

	
	5) Logical Operators
			a) and operator: Called Logical AND operator. If both the operands are true, then the condition becomes true.
							Example: (a and b) is true.

			b) or operator: Called Logical OR Operator. If any of the two operands are non zero, then the condition becomes true.
							Example: (a or b) is true.
				
			c) && operator: Called Logical AND operator. If both the operands are non zero, then the condition becomes true.
							Example: (a && b) is true.
				
			d) || operator: Called Logical OR Operator. If any of the two operands are non zero, then the condition becomes true.
							Example: (a || b) is true.
				
			e) ! operator: Called Logical NOT Operator. Use to reverses the logical state of its operand. If a condition is true, then Logical NOT operator will make false.
							Example: !(a && b) is false.
				
			f) not operator: Called Logical NOT Operator. Use to reverses the logical state of its operand. If a condition is true, then Logical NOT operator will make false.
							Example: not(a && b) is false.
				
 
	6) Ternary Operator
			 ?: operator: 
			 	Example: If Condition is true ? Then value X : Otherwise value Y


	7) Range Operators
			.. operator: Creates a range from start point to end point inclusive.
				Example: 1..10 Creates a range from 1 to 10 inclusive.

			... operator: Creates a range from start point to end point exclusive.
				Example: 1...10 Creates a range from 1 to 9.


# Decision Making
	A programming language uses control statements to control the flow of execution of the program based on certain conditions.
	These are used to cause the flow of execution to advance and branch based on changes to the state of a program.
	Decision-Making Statements:

		1)if statement:
				If statement in Ruby is used to decide whether a certain statement or block of statements will be executed or not i.e if a certain condition is true then a block of statement is executed otherwise not.
			Syntax: 
						if (condition) 
						end  
			Example:
								a = 20
								if a >= 18
  								puts "You are eligible to vote."
								end


		2)if-else statement:	
				In this ‘if’ statement used to execute block of code when the condition is true and ‘else’ statement is used to execute a block of code when the condition is false.
			Syntax:
						if(condition)  
						else  
						end  
			example: 
							a = 15
							if a >= 18
  							puts "You are eligible to vote."
							else
  							puts "You are not eligible to vote."
							end


		3)if – elsif ladder:
				Here, a user can decide among multiple options. ‘if’ statements are executed from the top down. 
				As soon as one of the conditions controlling the ‘if’ is true, the statement associated with that ‘if’ is executed, and the rest of the ladder is bypassed. 
				If none of the conditions is true, then the final else statement will be executed.
			Syntax:
						if(condition1)  
						elsif(condition2)
						else(condition3)  
						end 
			example: 
							a = 78 
							if a  < 50  
  							puts "Student is failed" 
							elsif a >= 50 && a <= 60  
  							puts "Student gets D grade" 
							elsif a >= 70 && a <= 80  
  							puts "Student gets B grade"
							elsif a >= 80 && a <= 90  
  							puts "Student gets A grade"
							elsif a >= 90 && a <= 100  
  							puts "Student gets A+ grade"   
							end 

		4)Ternary statement:
				In Ruby ternary statement is also termed as the shortened if statement. 
				It will first evaluate the expression for true or false value and then execute one of the statements. 
				If the expression is true, then the true statement is executed else false statement will get executed.
			Syntax:
							test-expression ? if-true-expression : if-false-expression 
			Example:
							var = 5;
							a = (var > 2) ? true : false ;
							puts a
			Output: True
			


# Loops

    1) While Loop
        Executes code while conditional is true
        Syntax:
                while condition
                            code
                end

        example: 
                x = 4
                while x >= 1
                    puts "Nishchay Gupta"
                    x = x - 1
                end


    2) Do While Loop
        A while loop conditional is separated from code by the reserved word do, a newline, backslash \, or a semicolon ;.
        Syntax:
                while conditional [do]
                    code
                end

            example: 
                    loop do
                       puts "Nishchay"
                       val = '7'
                       if val == '7'
                          break
                       end
                    end


    3) For Loop
        Executes code once for each element in expression.
        Syntax: 
                for variable [, variable ...] in expression [do]
                    code
                end
            
        example: 
                i = "Nishchay"
                for a in 1..5 do
                    puts i 
                end


    4) Until Loop
    Executes code while conditional is false.
    If an until modifier follows a begin statement with no rescue or ensure clauses, code is executed once before conditional is evaluated.
        Syntax:
                code until conditional
                        OR
                begin
                    code
                end until conditional

        example:    
                var = 7
                until var == 11 do
                    puts var * 10
                    var = var + 1
                end



# Methods
Method is a collection of statements that perform some specific task and return the result.
Methods are time savers and help the user to reuse the code without retyping the code
In Ruby, the method defines with the help of def keyword followed by method_name and end with end keyword. 
A method must be defined before calling and the name of the method should be in lowercase. 
Methods are simply called by its name. 

Syntax:
def method_name
# Statement 1
# Statement 2
.
.
end

Example:
def printing
puts "Hello Nishchay"
end
 
printing     // calling method


				1) Passing parameters to methods: 
						Parameter passing is similar to other programming language’s parameter passing i.e simply write the parameters in the brackets (). 

						Syntax:
						def method_name(var1, var2, var3)
						# Statement 1
						# Statement 2
						.
						.
						end

						Example:
						def geeks (var1 = "GFG", var2 = "G4G")
     					puts "First parameter is #{var1}"
     					puts "First parameter is #{var2}"
						end
						geeks "GeeksforGeeks", "Sudo"    # calling method with parameters
 						puts ""
						puts "Without Parameters"
						puts ""
						geeks                            # calling method without passing parameters

						Output:
						First parameter is GeeksforGeeks
						First parameter is Sudo

						Without Parameters

						First parameter is GFG
						First parameter is G4G


				2) Variable Number of Parameters: 
						Ruby allows the programmer to define a method that can take the variable number of arguments. 
						It is useful when the user doesn’t know the number of parameters to be passed while defining the method. 

						Syntax:
						def method_name(*variable_name)
						# Statement 1
						# Statement 2
						.
						.
						end

						Example:
						def geeks (*var)
							puts "Number of parameters is: #{var.length}"
							for i in 0...var.length
      					puts "Parameters are: #{var[i]}"
   						end
						end
						geeks "GFG", "G4G"
						geeks "GeeksforGeeks"

						Output:
						Number of parameters is: 2
						Parameters are: GFG
						Parameters are: G4G
						Number of parameters is: 1
						Parameters are: GeeksforGeeks

				3) Return statement in Methods:
						Return statement used to returns one or more values. 
						By default, a method always returns the last statement that was evaluated in the body of the method. 
						‘return’ keyword is used to return the statements. 

						Example:
						def addition
							a = 10
							b = 39
							sum = a+b
							return sum
						end
						puts "The result is: #{num}"    # calling of num method

	

# Blocks
A block consists of chunks of code.
You assign a name to a block.
The code in the block is always enclosed within braces ({}).
A block is always invoked from a function with the same name as that of the block. This means that if you have a block with the name test, then you use the function test to invoke this block.
You invoke a block by using the yield statement.

Syntax: 
block_name {
   statement1
   statement2
   ..........
}

* The yield Statement:
Example:
def test
   puts "You are in the method"
   yield
   puts "You are again back to the method"
   yield
end
test {puts "You are in the block"}

Output:
You are in the method
You are in the block
You are again back to the method
You are in the block



# Modules and Mixins
Modules are a way of grouping together methods, classes, and constants. 
Modules give you two major benefits.
- Modules provide a namespace and prevent name clashes.
- Modules implement the mixin facility.

Syntax:
module Identifier
   statement1
   statement2
   ...........
end

Example:
module Trig
   PI = 3.141592654
   def Trig.sin(x)
   end
   def Trig.cos(x)
   end
end


			 Ruby require Statement:-

			 Syntax:
			 require filename

			 Example:
			 $LOAD_PATH << '.'	
			 require 'trig.rb'
			 y = Trig.sin(Trig::PI/4)

We are using $LOAD_PATH << '.' to make Ruby aware that included files must be searched in the current directory.


				Ruby include Statement:-

				Syntax:
				include modulename

				Example:
				module Week
   				FIRST_DAY = "Sunday"
   				def Week.weeks_in_month
      			puts "You have four weeks in a month"
   				end
   				def Week.weeks_in_year
      			puts "You have 52 weeks in a year"
   				end
				end

				$LOAD_PATH << '.'
				require "support"

				class Decade
				include Week
   				no_of_yrs = 10
   				def no_of_months
      			puts Week::FIRST_DAY
      			number = 10*12
      			puts number
   				end
				end
				d1 = Decade.new
				puts Week::FIRST_DAY
				Week.weeks_in_month
				Week.weeks_in_year
				d1.no_of_months

				Output:
				Sunday
				You have four weeks in a month
				You have 52 weeks in a year
				Sunday
				120




# Ranges
Ranges occur everywhere: January to December, 0 to 9, lines 50 through 67, and so on.

Types:
1) Ranges as Sequences:
	Ranges are commonly used to represent sequences of values:

		* Inclusive Range (..): Includes both the start and end values.
			Example:
					inclusive_range = 1..5
					puts inclusive_range.to_a.inspect
			# Output: [1, 2, 3, 4, 5]

		* Exclusive Range (...): Includes values up to, but not including, the end value
			Example:
					exclusive_range = 1...5
					puts exclusive_range.to_a.inspect
			# Output: [1, 2, 3, 4]

		* Iterating Over a Range:
			Example:
					(1..5).each { |num| puts num }
			# Output:
						# 1
						# 2
						# 3
						# 4
						# 5

		* Checking Membership:
			Example:
					range = 1..10
					puts range.include?(5)  # true
					puts range.include?(15) # false


2) Ranges as Conditions
Ranges can be used as conditions to check if a value falls within a specified range:
		Example:
				score = 85
				grade = case score
  					when 90..100
    					"A"
  					when 80..89
    					"B"
  					when 70..79
    					"C"
  					when 60..69
    					"D"
  					else
    					"F"
				end
				puts "Your grade is #{grade}"
		# Output: Your grade is B


3) Ranges as Intervals
A final use of the versatile range is as an interval test: seeing if some value falls within the interval represented by the range. 
This is done using ===, the case equality operator.

		* Numerical Range
			Example:
					if (1..10) === 5
						puts "5 lies in (1..10)"
  					end
			# Output: 5 lies in (1..10)

		* Character Range
			Example:
					if ('a'..'j') === 'c'
						puts "c lies in ('a'..'j')"
  					end
			# Output: c lies in ('a'..'j')

		* Character Range (out of range)
				Example:
						if ('a'..'j') === 'z'
							puts "z lies in ('a'..'j')"
  						end
			# Output: nil



# Iterarors
Iterators are nothing but methods supported by collections. 
Objects that store a group of data members are called collections. 
In Ruby, arrays and hashes can be termed collections.
Iterators return all the elements of a collection, one after the other.

		* each Iterator
			The each iterator returns all the elements of an array or a hash.
			Syntax:
					collection.each do |variable|
						code
 					end

			Example:
					ary = [1,2,3,4,5]
					ary.each do |i|
					   puts i
					end
			# Output:
					1
					2
					3
					4
					5


		* collect Iterator
			The collect iterator returns all the elements of a collection.
			Syntax:
					collection = collection.collect

			Example:
					a = [1,2,3,4,5]
					b = Array.new
					b = a.collect
					puts b
			# Output:
					1
					2
					3
					4
					5




# File I/O
Ruby provides a whole set of I/O-related methods implemented in the Kernel module. 
All the I/O methods are derived from the class IO.
The class IO provides all the basic methods, such as read, write, gets, puts, readline, getc, and printf.

		* puts Statement ->
		The puts statement instructs the program to display the value stored in the variable. 
		This will add a new line at the end of each line it writes.

		Example:
		      val = "Hello World"
		      puts val
		Output:
		      Hello World
			
					
		* gets Statement ->
		The gets statement can be used to take any input from the user from standard screen called STDIN.

		Example:
			puts "Enter your name:"
			name = gets.chomp  # 'chomp' removes the trailing newline character
			puts "Hello, #{name}!"
		Output:
			Enter your name:
			Nishchay
			Hello, Nishchay!

		
		* putc Statement ->
		The output of the following code is just the character H 

		Example:
				str = "Hello Ruby!"
				putc str
		Output:
				H => "Hello Ruby!" 


		* print Statement ->
	    The print statement is similar to the puts statement. 
		The only difference is that the puts statement goes to the next line after printing the contents, whereas with the print statement the cursor is positioned on the same line.

		Example:
				print "Hello World"
				print "Good Morning"
		Output:
				Hello WorldGood Morning


	Opening and Closing Files
		* The File.new Method ->
		We can create a File object using File.new method for reading, writing, or both, according to the mode string. 
		Syntax:
				aFile = File.new("filename", "mode")
				# ... process the file
	 			aFile.close

		* The File.open Method ->
		We can use File.open method to create a new file object and assign that file object to a file. 
		However, there is one difference in between File.open and File.new methods. 
		The difference is that the File.open method can be associated with a block, whereas you cannot do the same using the File.new method.
		Syntax:
				File.open("filename", "mode") do |aFile|
				# ... process the file
		 		end


	Reading and Writing Files
		* The sysread Method ->
		We can use the method sysread to read the contents of a file. 
		We can open the file in any of the modes when using the method sysread.
		Example:
			aFile = File.new("input.txt", "r")
			if aFile
   				content = aFile.sysread(20)
   				puts content
			else
   				puts "Unable to open file!"
			end
		
		* The syswrite Method ->
		We can use the method syswrite to write the contents into a file. 
		We need to open the file in write mode when using the method syswrite.
		Example:
			aFile = File.new("input.txt", "r+")
			if aFile
   				aFile.syswrite("ABCDEF")
			else
   				puts "Unable to open file!"
			end

		* The each_byte Method ->
		This method belongs to the class File. 
		The method each_byte is always associated with a block.
		Example:
			aFile = File.new("input.txt", "r+")
			if aFile
		   		aFile.syswrite("ABCDEF")
		   		aFile.each_byte {|ch| putc ch; putc ?. }
			else
		   		puts "Unable to open file!"
			end
		
		* The IO.readlines Method ->
		The class File is a subclass of the class IO. 
		The class IO also has some methods, which can be used to manipulate files.
		One of the IO class methods is IO.readlines. 
		This method returns the contents of the file line by line.
		Example:
			arr = IO.readlines("input.txt")
			puts arr[0]
			puts arr[1]

		* The IO.foreach Method ->
		This method also returns output line by line. 
		The difference between the method foreach and the method readlines is that the method foreach is associated with a block. 
		However, unlike the method readlines, the method foreach does not return an array.
		Example:
		IO.foreach("input.txt"){|block| puts block}

		
	Renaming and Deleting Files
		* Rename Method ->
			Example:
			File.rename( "test1.txt", "test2.txt" )

		* Delete Method ->
			Example:
			File.delete( "test2.txt" )


	File Modes and Ownership
		Use the chmod method with a mask to change the mode or permissions/access list of a file
		Example:
		file = File.new( "test.txt", "w" )
		file.chmod( 0755 )

	
	File Inquiries
		* The following command tests whether a file exists before opening it
		Example:
			File.open("file.rb") if File::exists?( "file.rb" )

		* The following command inquire whether the file is really a file 
		Example:
			File.file?( "file.rb" )

		* The following command inquire whether the file is really a directory
		Example:
			File::directory?( "/usr/local/bin" ) # => true
			File::directory?( "file.rb" ) # => false

		* The following command finds whether the file is readable, writable or executable
		Example:
			File.readable?( "file.rb" )
			File.writable?( "file.rb" )
			File.executable?( "file.rb" )

		* The following command finds whether the file has zero size or not
		Example:
			File.zero?( "file.rb" )

		* The following command returns size of the file
		Example:
			File.size?( "file.rb" )    # => 1002

		* The following command can be used to find out a type of file 
		Example:
			File::ftype( "test.txt" )     # => file
			The ftype method identifies the type of the file by returning one of the following file, directory, characterSpecial, blockSpecial, fifo, link, socket, or unknown.

		* The following command can be used to find when a file was created, modified, or last accessed
		Example:
			File::ctime( "test.txt" ) # => Fri May 09 10:06:37 -0700 2021
			File::mtime( "text.txt" ) # => Fri May 09 10:44:44 -0700 2024
			File::atime( "text.txt" ) # => Fri May 09 10:45:01 -0700 2024
		

	Directories in Ruby
	All files are contained within various directories, and Ruby has no problem handling these too. 
	Whereas the File class handles files, directories are handled with the Dir class.

		* Creating a Directory ->
		The Dir.mkdir can be used to create directories
		Example:
			Dir.mkdir("mynewdir")

		You can also set permissions on a new directory (not one that already exists) with mkdir
		Example:
			Dir.mkdir( "mynewdir", 755 )


		* Deleting a Directory ->
		The Dir.delete can be used to delete a directory. 
		The Dir.unlink and Dir.rmdir performs exactly the same function and are provided for convenience.
		Example:
			Dir.delete("mynewdir")

		
		* Navigating Through Directories ->
			Change Directory :->
			To change the current working directory in a Ruby program, use Dir.chdir. This changes the current directory to the specified path.
			Example:
		    	Dir.chdir("/usr/bin")

			Get Current Directory :->
			To find out what the current directory is, use Dir.pwd.
			Example:
				puts Dir.pwd  # Output: /usr/bin

			Listing Directory Contents :->
			To get a list of files and directories within a specific directory, use Dir.entries:
			Example:
				puts Dir.entries("/usr/bin")
			This returns an array of entries in the specified directory. 

			Alternatively, Dir.foreach can be used to iterate over each entry:
			Example:
				Dir.foreach("/usr/bin") do |entry|
					puts entry
			  	end

			Another concise way to get directory listings is by using Dir.glob:
			Example:
				Dir["/usr/bin/*"]


		* Creating Files & Temporary Directories ->
			Temporary Directory Path :->
			To access the temporary directory path, use Dir.tmpdir. 
			This requires the tmpdir library:
			Example:
				require 'tmpdir'
				temp_dir = Dir.tmpdir

			Creating a Temporary File :->
			You can create a platform-independent temporary file using File.join with Dir.tmpdir:
			Example:
				require 'tmpdir'
				tempfilename = File.join(Dir.tmpdir, "tempfile.txt")
				tempfile = File.new(tempfilename, "w")
				tempfile.puts "This is a temporary file"
				tempfile.close
				File.delete(tempfilename)
			This code creates a temporary file, writes data to it, and then deletes it

			Using Tempfile Library :->
			Rubys standard library includes the Tempfile class for creating temporary files:
			Example:
				require 'tempfile'
				tempfile = Tempfile.new('my_temp_file')
				tempfile.puts "Hello"
				puts tempfile.path  # Prints the path to the temporary file
				tempfile.close
				This example creates a temporary file, writes a string to it, and prints its path. 
				The file is automatically deleted when the Tempfile object is closed.

