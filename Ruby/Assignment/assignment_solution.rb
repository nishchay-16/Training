                           RUBY ASSIGNMENT SOLUTIONS

STRING

Q1) Create a function that takes an array of strings and integers, and filters out the array so that it returns an
    array of integers only.
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


Q3) Given a string s, reverse only all the vowels in the string and return it.The vowels are 'a', 'e', 'i', 'o', and 'u',
    and they can appear in both cases.
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


Q4) Given an n-digit large number in form of string, check whether it is divisible by 7 or not. Print 1 if divisible
    by 7, otherwise 0.
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