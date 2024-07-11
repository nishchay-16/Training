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

