                           RUBY ASSIGNMENT SOLUTIONS

<-------------------------------------STRING----------------------------------------->

Q1) Create a function that takes an array of strings and integers, and filters out the array so that it returns an array of integers only.
Ans->
    def filter_int(arr)
        arr.select { |x| x.is_a?(Integer) }
    end

    result = filter_int([1, 2, "a", 8, "b", 78])
    puts result.inspect
    # Output: [1, 2, 8, 78]
    

Q2) Write a function to return reverse of a string using recursion.
Ans->
    def reverse_str(str)
        return str if str.length <= 1
        str[-1] + reverse_str(str.chop)
    end

    puts reverse_str("I am Nishchay Gupta")
    # Output: atpuG yahchsiN ma I


Q3) Given a string s, reverse only all the vowels in the string and return it.The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both cases.
Ans->
    def reverse_vowels(s)
        vowels = "aeiouAEIOU"
        chars = s.chars
        left = 0
        right = chars.length - 1
        while left < right
            if vowels.include?(chars[left]) && vowels.include?(chars[right])
              chars[left], chars[right] = chars[right], chars[left]
              left += 1
              right -= 1
            elsif vowels.include?(chars[left])
              right -= 1
            else
              left += 1
            end
        end       
        chars.join
    end 

    puts reverse_vowels('Nishchay')
    # Output: Nashchiy


Q4) Given an n-digit large number in form of string, check whether it is divisible by 7 or not. Print 1 if divisible by 7, otherwise 0.
Ans->
    def check_disivibility(str)
        if str.to_i % 7 == 0
            puts 1
        else 
            puts 0
        end 
    end

    puts check_disivibility("1234567")
    # Output: 0


Q5 Given a string S, print all permutations of a given string.
Ans->
    def permutation(str)
        p = str.chars
        p.permutation.map {|x| x.join}
    end

    puts permutation("cap")
    # Output: 
    cap
    cpa
    acp
    apc
    pca
    pac


Q6 Given a String S, reverse the string without reversing its individual words. Words are separated by dots.
Ans->
    def reverse_words(str)
        str.split(".").reverse.join(".")
    end

    puts reverse_words("I.am.Nishchay.Gupta")
    # Output: Gupta.Nishchay.am.I


Q7 Given two strings s and t, return true if t is an anagram of s, and false otherwise.
Ans->
    def is_anagram(s, t)
        if s.chars.sort == t.chars.sort
            return true
        else
            return false
        end
    end

    puts is_anagram("worth", "throw")
    # Output: true


Q8) A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all
    non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include
    letters and numbers. Given a string s, return true if it is a palindrome, or false otherwise.
Ans->
    def is_palindrome(str)
        clean_str = str.downcase.gsub(/[^a-z0-9]/, '')
        clean_str.downcase == clean_str.downcase.reverse
    end

    puts is_palindrome("naman @ nam-an")
    # Output: true


Q9) Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.
Ans->
    def first_non_rep(str)
        arr = str.chars
        for i in 0...arr.length
          char = arr[i]
          repeated = false
          for j in 0...arr.length
            if i != j && arr[j] == char
              repeated = true
              break
            end
          end
          unless repeated
            return i
          end
        end
        return -1  
    end
      
    puts first_non_rep("Nishchay")
    # Output: 0


Q10) Given a string s and an array of strings words, determine whether s is a prefix string of words.
     A string s is a prefix string of words if s can be made by concatenating the first k strings in words for some
     positive k no larger than words.length. Return true if s is a prefix string of words, or false otherwise.
Ans->
    def is_prefix_string(s, words)
        prefix = ""
        words.each do |word|
            prefix += word
            return true if prefix == s
            return false if prefix.length > s.length
        end
        return false
    end

    puts is_prefix_string("Nishchay", ["Nishchay","Naman","Paarth"])
    # Output: true


Q11) You are given an array of strings nums and an integer k. 
     Each string in nums represents an integer without leading zeros.
     Return the string that represents the kth largest integer in nums.
     Note: Duplicate numbers should be counted distinctly. 
     For example, if nums is ["1","2","2"], "2" is the first largest integer, "2" is the second-largest integer, and "1" is the third-largest integer.   
Ans->
    def find_kth_largest(nums, k)
        nums.sort[-k]
        puts "The #{k} largest number in the array is: #{nums[k]}" 
    end

    puts find_kth_largest(["1","9","2"], 1)
    # Output: The 1 largest number in the array is: 9


Q12) Given two strings s and part, perform the following operation on s until all occurrences of the substring part are removed:
     Find the leftmost occurrence of the substring part and remove it from s.Return s after removing all occurrences of part.
     A substring is a contiguous sequence of characters in a string.
Ans->
    def remove_occurrences(s, part)
        while s.include?(part)
            s.slice! part
        end
        return s
    end
                  OR 
    def remove_occurrences(s, part)
        while s.include?(part)
            s.gsub!(part, '')
        end
        return s
    end

    puts remove_occurrences("daabcbaabcbcc", "abc")
    # Output: d


Q13) You are given the array paths, where paths[i] = [cityAi, cityBi] means there exists a direct path going from cityAi to cityBi. 
     Return the destination city, that is, the city without any path outgoing to another city.
     It is guaranteed that the graph of paths forms a line without any loop, therefore, there will be exactly one destination city.
        Input: paths = [["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]]
        Output: "Sao Paulo"
        Explanation: Starting at "London" city you will reach "Sao Paulo" city which is the destination city. 
                     Your trip consist of: "London" -> "New York" -> "Lima" -> "Sao Paulo"
Ans->
    def destination_city(paths)
        start , destination = [], []
        paths.each do |path|
            start << path[0]
            destination << path[1]
        end
        puts (destination - start)[0]
    end

    puts destination_city([["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]])
    # Output: Sao Paulo



<--------------------------------------------ARRAY------------------------------------------->

Q14) Write a function which takes an integer (positive) and return an array of factorials of each index in index position till given number.
Ans->
    def factorial(num)
        fact = 1
        fact_arr = []
        for i in 1..num
            fact = fact * i
            fact_arr << fact
        end
        return fact_arr
    end

    factorial(5)
    # Output:  [1, 2, 6, 24, 120]


Q15)  Create a function that takes an array of numbers and returns a new array containing only prime numbers.
Ans->
    def filter_primes(arr)
        primes = []
        for i in arr do
            if i == 2
                primes << i
            elsif i > 2
                for j in 2..i-1 do
                    if i % j == 0
                        break
                    elsif j == i-1
                        primes << i
                    end
                end
            end
        end
        return primes   
    end

    puts filter_primes([1, 2, 7 , 9, 3, 9, 10, 11, 27])
    # Output: [2, 3, 7, 11]


Q16) Given an integer limit being the upper limit of the range of interest, implement a function that returns the
     last 15 palindromes numbers lower or equal to limit as an array sorted ascendingly.
Ans->  
    def last_fifteen(limit)
        arr = []
        for i in 0..limit do
            if i.to_s == i.to_s.reverse
                arr << i
            end
        end
        return arr[-15..-1]
    end

    puts last_fifteen(100)
    # Output: [151, 161, 171, 181, 191, 202, 212, 222, 232, 242, 252, 262, 272, 282, 292]


Q17) Write a function which takes an integer (positive) and return an array of Fibonacci number of each index in index position till given number
Ans->
    def fibonacci(num)
        init = [0, 1]
        for i in 2..num
            init << init[i-1] + init[i-2]
        end
        return init
    end

    puts fibonacci(10)
    # Output: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]


Q18) Write a function which takes an array of integers, return how many of them contain an even number of digits.
Ans->
    def even_digits(arr)
        count = 0
        for i in arr do 
            if i.to_s.length.even?
                count += 1
            end
        end
        return count
    end 

    puts even_digits([12, 345, 2, 6, 7896])
    # Output: 2


Q19) Given an integer array nums, find a contiguous non-empty subarray within the array that has the largest product, and return the product. 
     Elements can also be negative numbers.
            Input: nums = [2,3,-2,4]
            Output: 6
            Explanation: [2,3] has the largest product 6.
Ans->


Q20) Given an unsorted array Arr of size N of positive integers. One number 'A' from set {1, 2, …N} is missing
     and one number 'B' occurs twice in array. Find these two numbers.
Ans->
    def find_numbers(arr)
        repeat = arr.find {|i| arr.count(i) > 1}
        missing = (1..arr.size).find {|i| !arr.include?(i)}
        return [repeat, missing]
    end

    puts find_numbers([1, 2, 2, 4])
    # Output: [2, 3]


Q21) Write a function that takes an integer (less than 1000) and return an array of primes till that number.
Ans->
    def primes(num)
        arr=[]
        if num >= 1000
            puts "Number should be less than 1000"
        else
            for i in 2..num do
                if i == 2
                arr << i
                elsif i > 2
                    for j in 2..i-1 do
                        if i % j == 0
                            break
                        elsif j == i-1
                            arr << i
                        end
                    end
                end
            end 
        end
        return arr
    end

    puts primes(50)
    # Output: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
