                                         EXCPEPTION HANDLING IN RUBY

Exceptions are special objects in Ruby that represent errors or unexpected conditions that occur during the execution of a program.
When an exception occurs, Ruby stops the normal flow of the program and looks for special code (called exception handlers) to deal with the error.

Why Handle Exceptions?
1) Prevent Program Crashes:->  
    Without exception handling, an unexpected error can cause your entire program to crash. 
    By handling exceptions, you can ensure that your program continues to run or shuts down gracefully.

2) Improve User Experience:->
    Handling exceptions allows you to provide meaningful error messages to users, helping them understand what went wrong and possibly how to fix it.

3) Maintain Data Integrity:->
    Proper exception handling can ensure that data remains consistent and valid, even when errors occur. 
    This is particularly important in applications that interact with databases or other persistent storage.

4) Debugging and Logging:-> 
    Exception handling can be used to log errors, making it easier to debug and maintain the application.

5) Control Flow:->
    In some cases, exceptions can be used to manage the flow of a program, especially when dealing with complex operations that might fail under certain conditions.



The program stops if an exception occurs. So exceptions are used to handle various type of errors, which may occur during a program execution and take appropriate action instead of halting program completely.
Ruby provide a nice mechanism to handle exceptions. 
We enclose the code that could raise an exception in a begin/end block and use rescue clauses to tell Ruby the types of exceptions we want to handle.

Syntax:
begin  
    # -  
    rescue OneTypeOfException  
    # -  
    rescue AnotherTypeOfException  
    # -  
    else  
    # Other exceptions
    ensure
    # Always will be executed
end
    
Explanation:->
begin: Starts the block of code where you want to handle exceptions.
rescue: Catches exceptions that occur in the begin block.
ensure: Ensures that the code inside it will run whether an exception occurs or not.
end: Ends the exception handling block.

Example:
begin
    file = File.open("non_existent_file.txt")
    if file
      puts "File opened successfully"
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
  ensure
    puts "Ensuring execution"
  end
  


<---------- Exception handling using some statements ----------->

1) Using retry Statement:-----> 
We can capture an exception using rescue block and then use retry statement to execute begin block from the beginning.
The following is the flow of the process :
-> An exception occurred at open.
-> Went to rescue. fname was re-assigned.
-> By retry went to the beginning of the begin.
-> This time file opens successfully.
-> Continued the essential process.

Syntax:
begin
    # Exceptions raised by this code will 
    # be caught by the following rescue clause
 rescue
    # This block will capture all types of exceptions
    retry  # This will move control to the beginning of begin
 end

Example:
begin
    file = open("/unexistant_file")
    if file
       puts "File opened successfully"
    end
 rescue
    fname = "existant_file"
    retry
 end


2) Using raise Statement:----->
We can use raise statement to raise an exception. 
The following method raises an exception whenever it's called. 
It's second message will be printed.

Syntax:
raise 
OR
raise "Error Message" 
OR
raise ExceptionType, "Error Message"
OR
raise ExceptionType, "Error Message" condition

Forms of Raise Statement:
* The first form simply re-raises the current exception (or a RuntimeError if there is no current exception). This is used in exception handlers that need to intercept an exception before passing it on.
* The second form creates a new RuntimeError exception, setting its message to the given string. This exception is then raised up the call stack.
* The third form uses the first argument to create an exception and then sets the associated message to the second argument.
* The fourth form is similar to the third form but you can add any conditional statement like unless to raise an exception.

Example 1 :
begin  
    puts 'I am before the raise.'  
    raise 'An error has occurred.'  
    puts 'I am after the raise.'  
 rescue  
    puts 'I am rescued.'  
 end  
 puts 'I am after the begin block.'  
# Output:
I am before the raise.  
I am rescued.  
I am after the begin block.  

Example 2:
begin  
    raise 'A test exception.'  
 rescue Exception => e  
    puts e.message  
    puts e.backtrace.inspect  
 end  
# Output:
A test exception.
["main.rb:4"]


3) Using ensure Statement:----->
The ensure statement in Ruby is used to specify a block of code that should always run, regardless of whether an exception was raised in the begin block.
This is particularly useful for cleanup operations, such as closing files, releasing resources, or other tasks that must be performed regardless of the outcome of the preceding code.
The ensure clause does just this. ensure goes after the last rescue clause and contains a chunk of code that will always be executed as the block terminates.
It doesnt matter if the block exits normally, if it raises and rescues an exception, or if it is terminated by an uncaught exception, the ensure block will get run.

Syntax:
begin 
    #.. process 
    #..raise exception
 rescue 
    #.. handle error 
 ensure 
    #.. finally ensure execution
    #.. This will always execute.
 end

Example:
 begin
    raise 'A test exception.'
 rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
 ensure
    puts "Ensuring execution"
 end
# Output:
A test exception.
["main.rb:4"]
Ensuring execution


4) Using else Statement:------->
If the else clause is present, it goes after the rescue clauses and before any ensure.
The body of an else clause is executed only if no exceptions are raised by the main body of code.

Syntax:
begin 
    #.. process 
    #..raise exception
 rescue 
    # .. handle error
 else
    #.. executes if there is no exception
 ensure 
    #.. finally ensure execution
    #.. This will always execute.
 end

Example:
begin
    # raise 'A test exception.'
    puts "I'm not raising exception"
 rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
 else
    puts "Congratulations-- no errors!"
 ensure
    puts "Ensuring execution"
 end
# Output:
I m not raising exception
Congratulations-- no errors!
Ensuring execution


5) Catch and Throw:--------->
The catch defines a block that is labeled with the given name (which may be a Symbol or a String). 
The block is executed normally until a throw is encountered.

Syntax:
throw :lablename
#.. this will not be executed
catch :lablename do
#.. matching catch will be executed after a throw is encountered.
end

OR

throw :lablename condition
#.. this will not be executed
catch :lablename do
#.. matching catch will be executed after a throw is encountered.
end

Example:
def promptAndGet(prompt)
    print prompt
    res = readline.chomp
    throw :quitRequested if res == "!"
    return res
 end
 catch :quitRequested do
    name = promptAndGet("Name: ")
    age = promptAndGet("Age: ")
    sex = promptAndGet("Sex: ")
    # ..
    # process information
 end
 promptAndGet("Name:")

# Output:
Name: Ruby on Rails
Age: 3
Sex: !
Name:Just Ruby

