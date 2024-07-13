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
    def max_product(arr)
        max = arr[0]
        min = arr[0]
        max_product = arr[0]
        for i in 1..arr.length-1 do
            if arr[i] < 0
                max, min = min, max
            end
            max = [max * arr[i], arr[i]].max
            min = [min * arr[i], arr[i]].min
            max_product = [max, max_product].max
        end
        return max_product
    end

    puts max_product([2, 3, -2, -3, -10, 5])
    # Output: 150


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


Q22) Given an integer array nums and an integer k, return the number of pairs (i, j) where i < j such that
        |nums[i] - nums[j]| == k.
     The value of |x| is defined as:
        x if x >= 0.
        -x if x < 0.
Ans->
    def pairs(arr, k)
        pair = []
        for i in 0..arr.length-1
            for j in (i+1)..arr.length-1
                if (arr[i] - arr[j]).abs == k
                    pair << [arr[i], arr[j]]
                end
            end
        end
        return pair
    end

    puts pairs([-1, 1, 2, 3, 4, 5], 2).inspect
    # Output: [[-1, 1], [1, 3], [2, 4], [3, 5]]


Q23) Given an array nums. We define a running sum of an array as running Sum[i] = sum( nums[0]…nums[i]).
     Return the running sum of nums.
Ans-> 
    def running_sum(arr)
        sum = []
        for i in 0..arr.length-1
            sum << arr[0..i].sum
        end
        return sum
    end

    puts running_sum([1, 2, 3, 4])
    # Output: [1, 3, 6, 10]


Q24) Write a function which takes square matrix mat, return the sum of the matrix diagonals.
     Only include the sum of all the elements on the primary diagonal and 
     all the elements on the secondary diagonal that are not part of the primary diagonal.
Ans->
    def primary_diagonal(mat)
        sum = 0
        for i in 0..mat.length-1
            for j in 0..mat.length-1
                if i == j || i + j == mat.length - 1
                    sum += mat[i][j]
                end
            end
        end
        return sum
    end

    puts primary_diagonal([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    # Output: 25


Q25) Given an array nums of size n, return the majority element. 
     The majority element is the element that appears more than ⌊n / 2⌋ times. 
     You may assume that the majority element always exists in the array.
Ans->
    def majority_element(arr)
        return arr.detect {|i| arr.count(i) > (arr.length/2)}
    end

    puts majority_element([3, 2, 3])
    # Output: 3


Q26) A distinct string is a string that is present only once in an array. 
     Given an array of strings arr, and an integer k, return the kth distinct string present in arr. 
     If there are fewer than k distinct strings, return an empty string "".
     Note that the strings are considered in the order in which they appear in the array.
Ans->
    def kth_distinct(arr, k)
        distinct = arr.select { |item| arr.count(item) == 1 } 
        if distinct.length >= k
            return distinct[k-1]
        else
            return ""
        end
    end

    puts kth_distinct(["1", "2", "3", "1", "3", "2", "4"], 1)
    # Output: "4"


Q27) Given an integer array nums, move all the even integers at the beginning of the array followed by all the  odd integers. 
     Return any array that satisfies this condition.
Ans->
    def rearrange(arr)
       even , odd = [] , []
       for i in 0..arr.length-1
           if arr[i] % 2 == 0
               even << arr[i]
           else
               odd << arr[i]
           end
       end
       return even + odd
    end

    puts rearrange([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    # Output: [2, 4, 6, 8, 10, 1, 3, 5, 7, 9]


Q28) Given an array of integers nums, return the number of good pairs.
     A pair (i, j) is called good if nums[i] == nums[j] and i < j
Ans->
    def good_pairs(arr)
        count = 0
        for i in 0..arr.length-1
            for j in (i+1)..arr.length-1
                if arr[i] == arr[j] && i < j
                    count += 1
                end
            end
        end
        return count
    end 
    
    puts good_pairs([1, 2, 3, 1, 1, 3])



<---------------------------------------------HASHES-------------------------------------------->

Q29)  Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
        Symbol Value
        I 1
        V 5
        X 10
        L 50
        C 100
        D 500
        M 1000
    Write a function which takes roman number and return integer corresponding to that roman number.
Ans->
    def roman_to_integer(s)
        roman = {'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}
        result = 0
        for i in s.chars
            result += roman[i]
        end
        return result
    end

    puts roman_to_integer("MCMXCIV")
    # Output: 2216
        

Q30) A pangram is a sentence where every letter of the English alphabet appears at least once.
     Given a string sentence containing only lowercase English letters, return true if sentence is a pangram, or false otherwise.
Ans-> 
    def is_pangram(s)
        letters = s.downcase.scan(/[a-z]/)
        letters.uniq.length == 26
    end

    puts is_pangram("The quick brown fox jumps over the lazy dog")

    #Output:
    true


Q31) Given an array of integers nums and an integer target, return indices of the two numbers such that they
add up to target. You may assume that each input would have exactly one solution, and you may not use
the same element twice. You can return the answer in any order.
Ans-> 
def two_sum(nums, target)
    hash = {}
    a=0
    for i in 0...nums.length
      a=target-nums[i]
      if hash.include?(a)
        return nums.index(a),i
      else
        hash.store(nums[i],nil)
      end
    end
  end
  nums=[3,2,4]
  print two_sum(nums,6)

#Output:
[1, 2] 


Q32) Given a string s, return true if s is a good string, or false otherwise. A string s is good if all the characters
that appear in s have the same number of occurrences (i.e., the same frequency).
Ans->
def are_occurrences_equal(s)
    arr = s.chars.uniq
    count=[]
  for i in 0..arr.length-1
    count.append(s.count(arr[i]))
  end
    if count.uniq.size==1
        return true
    else
        return false
    end
end

puts are_occurrences_equal("aabbccdd")
#Output:
true


Q33) Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range
that is missing from the array.
Ans->
def missing_number(nums)
    for i in 0..nums.length
        if nums.include?(i)
            next
        else
            return i
        end
    end
end

Q34) Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the
result must be unique and you may return the result in any order.
Ans->
def intersection(nums1, nums2)
    return nums1.intersection(nums2)
end

puts intersection([1,2,3],[1,4,5])
#Output:
[1]


Q35) You are given two strings of the same length s and t. In one step you can choose any character of t and
replace it with another character. Return the minimum number of steps to make t an anagram of s. An
Anagram of a string is a string that contains the same characters with a different (or the same) ordering.
Ans->
def replacing(s, t)
    def anagram(str1, str2)
      arr1=str1.chars.sort
      arr2=str2.chars.sort
      puts arr1.eql?(arr2)
    end
    steps=0
    for i in 0..s.length-1
    if anagram(s,t)
      return steps
    elsif t.include?(s[i])
      next
    else
      steps+=1
    end
    end
    return steps
  end


Q36)  Given a string text, you want to use the characters of text to form as many instances of the word "balloon"
      as possible. You can use each character in text at most once. Return the maximum number of instances
      that can be formed.
     Example: loonballxballpoon
     You can create only 2 balloon from example text, so return 2
Ans->
def max_instance(text)
    balloon = {
      'b' => 0,
      'a' => 0,
      'l' => 0,
      'o' => 0,
      'n' => 0
    }
    for i in 0...text.length
      if balloon.include?(text[i])
        balloon[text[i]]+=1
      end
    end
    balloon['l']/=2
    balloon['o']/=2
    return balloon.values.min
  end
  text='loonballxballpoon'
  puts max_instance(text)

  #Ouput:
  2


Q37) Given a string s which consists of lowercase or uppercase letters, return the length of the longest
palindrome that can be built with those letters.Letters are case sensitive, for example, "Aa" is not
considered a palindrome here.
Ans->
def longest_palindrome(s)
    count=0
    arr = s.chars.uniq
    hash = {}
    for i in 0...arr.length
      hash.store(arr[i],0)
    end
    for i in 0...s.length
      if hash.include?(s[i])
        hash[s[i]]+=1
      end
    end
    even=hash.select{|key,value| value%2==0}
    count+=even.length
    odd=hash.select{|key,value| value%2!=0}
    count+=odd.values.max
    return count
  end
  s='bcwsusc'
  puts longest_palindrome(s)

  #Output:
  3


Q38) Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a
     given target value.
        If target is not found in the array, return [-1, -1].
Ans->
def getting_day(str1)
    date=Date.parse(str1)
    puts date.strftime("%A")
  end
  require 'date'
  getting_day('12/07/2016')

  #Output:
  Tuesday


Q39) Given two unsorted arrays A of size N and B of size M of distinct elements, the task is to find all pairs from
both arrays whose sum is equal to X.
Ans->
def pairs(a, b, x)
    arr=[]
    for i in 0..a.length-1
      for j in 0..b.length-1
        if a[i]+b[j]==x
          arr.append([a[i],b[j]])
        end
      end
    end
    return arr
  end
  a=[2,3,4,5,6]
  b=[7,6,5,4,2]
  x=9
  print pairs(a,b,x)

  #Output:
    [[2, 7], [3, 6], [4, 5], [5, 4]]


    
<---------------------------------------Date & Time---------------------------------------------->

Q40)  Write a function which takes year and returns how many Saturday 14ths there are in a given year.
Ans->
def saturday(year)
    count=0
    for i in 1..12
    if Date.new(year,i,14).strftime('%A')=='Saturday'
      count+=1
    end
    end
    return count
  end
  require 'date'
  puts saturday(2021)

#Output:
1


Q41)  Create a function that converts dates from one of five string formats:
            "January 9, 2019" (MM D, YYYY)
            "Jan 9, 2019" (MM D, YYYY)
            "01/09/2019" (MM/DD/YYYY)
            "01-09-2019" (MM-DD-YYYY)
            "01.09.2019" (MM.DD.YYYY)
      The return value will be an array formatted like: [MM, DD, YYYY], where MM, DD, and YYYY are all integers.
Ans->
def convert(str)
    arr=[]
    if str.include?(",")
      date=Date.parse(str)
    end
    if str.include?("/")
      date=Date.parse(str, "%m/%d/%Y")
    end
    if str.include?('-')
      date=Date.parse(str, "%m-%d-%Y")
    end
    if str.include?('.')
      date=Date.parse(str, "%m.%d.%Y")
    end
    str_date = date.strftime("%m %d %Y")
    arr = str_date.split(" ") 
    return arr
  end
  require 'date'
  print convert("01/09/2019")

#Output:
["09", "01", "2019"] 


Q42) Create a function that takes time1 and time2 and return how many hours and minutes have passed
     between the two times.
Ans->
def difference(str1, str2)
    time1 = Time.parse(str1)
    time2 = Time.parse(str2)
    a=(time1-time2)/60
    b=(time1-time2)/3600
    return a,b
  end
  require 'time'
  puts difference('22:00:00','02:00:00')

#Output:
[1200.0, 20.0]


Q43) Write a function that, given a date (in the format MM/DD/YYYY), returns the day of the week as a string.
    Each day name must be one of the following strings: "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", or "Saturday".
    To illustrate, the day of the week for "12/07/2016" is "Wednesday".
Ans->
def getting_day(str1)
    date=Date.parse(str1)
    puts date.strftime("%A")
  end
  require 'date'
  getting_day('12/07/2016')

  #Output:
  Tuesday


Q44) Create a function that takes the month and year (as integers) and returns the number of days in that month.
Ans->
def total_days(m, y)
    Date.new(y,m,-1).day
  end
  require 'date'
  puts total_days(2,2020)

#Output:
29


Q45) Given a range of years as a string, return the number of leap years there are within the range (inclusive).
Ans->
def leap_year(y1, y2)
    arr=[]
    while y1<y2
      if Date.new(y1).leap?
        arr.append(y1)
      end
      y1+=1
    end
    return arr
  end
  require 'date'
  puts leap_year(2000,2010)

#Output:
[2000, 2004, 2008]


46) Given the parameters day, month and year, return whether that date is a valid date.
is_valid_date(35, 2, 2020) ➞ false
# February doesn't have 35 days.
Ans->
def valid_date(day,month,year)
    begin 
      Date.new(year,month,day)
    rescue
      puts 'Invalid Date'
    end
  end
  require 'date'
  puts valid_date(30,8,2022)

# Output:
2022-08-30


47) Given the month and year as numbers, return whether that month contains a Friday 13th.
Ans->
def friday(month, year)
    if Date.new(year,month,13).strftime('%A')=='Friday'
      return true
    else
      return false
    end
  end
  require 'date'
  puts friday(3,2021)

#Output:
false


48) Given a date, return how many days date is away from 2023 (end date not included). date will be in
mm/dd/yyyy format.
Ans->
def far_away(date)
    return (Date.parse(date)-Date.new(2022,12,31)).to_i.abs
end
require 'date'
puts far_away('19/08/2021')

#Output:
499


49) The 2nd of February 2020 is a palindromic date in both dd/mm/yyyy and mm/dd/yyyy format
(02/02/2020). Given a date in dd/mm/yyyy format, return true if the date is palindromic in both date
formats, otherwise return false
Ans->
def palindrom(date)
    date1=Date.parse(date).strftime('%d%m%Y')
      date2=Date.parse(date).strftime('%m%d%Y')
      date1.reverse.eql?(date2)
    end
    require 'date'
    puts palindrom('02/02/2020')

    #Output:
    true


50) If today was Monday, in two days, it would be Wednesday.
Create a function that takes in an array of days as input and the number of days to increment by. Return an
array of days after n number of days has passed.
after_n_days(["Thursday", "Monday"], 4) ➞ ["Monday", "Friday"]
Ans-> 
def increment(days, num)
    day = {
      0 => 'Sunday',
      1 => 'Monday', 
      2 => 'Tuesday',
      3 => 'Wednesday',
      4 => 'Thursday', 
      5 => 'Friday',
      6 => 'Saturday'
    }
    arr = []
    a=0
    for i in 0..days.length-1
      a=day.key(days[i])
      if a+num>6
        arr.append(day.fetch((a+num)-7))
      elsif
        arr.append(day.fetch(a+num))
      end
    end
    return arr
  end
  days = ["Thursday", "Monday"]
  print increment(days,4)

   # Output:-
  ["Monday", "Friday"]
