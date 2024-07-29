                      =====> ACTIVE RECORD QUERY INTERFACE <=====

The Active Record Query Interface in Rails is a powerful and flexible way to interact with the database. 
It allows you to construct SQL queries using Ruby methods, providing a clean and readable syntax for database interactions.


===> RETRIEVING OBJECTS FROM THE DATABASE
To retrieve objects from the database, Active Record provides several finder methods. 
Each finder method allows you to pass arguments into it to perform certain queries on your database without writing raw SQL.

Methods are:-
* annotate
* find
* create_with
* distinct
* eager_load
* extending
* extract_associated
* from
* group
* having
* includes
* joins
* left_outer_joins
* limit
* lock
* none
* offset
* optimizer_hints
* order
* preload
* readonly
* references
* reorder
* reselect
* regroup
* reverse_order
* select
* where

The primary operation of Model.find(options) can be summarized as:
-> Convert the supplied options to an equivalent SQL query.
-> Fire the SQL query and retrieve the corresponding results from the database.
-> Instantiate the equivalent Ruby object of the appropriate model for every resulting row.
-> Run after_find and then after_initialize callbacks, if any.
                    
1) Retrieving a Single Object -> Active Record provides several different ways of retrieving a single object.

      a) find 
      Using the find method, you can retrieve the object corresponding to the specified primary key that matches any supplied options.
          Example:
        * 3.3.0 :483 > book = Book.find(12)
          Book Load (0.5ms)  SELECT "books".* FROM "books" WHERE "books"."id" = $1 LIMIT $2  [["id", 12], ["LIMIT", 1]]
          => 
          #<Book:0x00000001219d3718
          3.3.0 :485 > book
          => 
          #<Book:0x00000001219d3718
            id: 12,
            isbn: "1234567890",
            title: "Book One",
            quantity: 5,
            created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
            updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
            available_quantity: 5,
            author_id: 13,
            genre_id: 1> 

        * 3.3.0 :486 > book = Book.find([6,10])
          Book Load (4.3ms)  SELECT "books".* FROM "books" WHERE "books"."id" IN ($1, $2)  [["id", 6], ["id", 10]]
           => 
          [#<Book:0x00000001216f9880
          ... 
          3.3.0 :487 > book
           => 
          [#<Book:0x00000001216f9880
            id: 6,
            isbn: nil,
            title: "Harry Potter and the Chamber of Secrets",
            quantity: nil,
            created_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
            updated_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
            available_quantity: nil,
            author_id: 10,
            genre_id: 2>,
           #<Book:0x00000001216f9740
            id: 10,
            isbn: nil,
            title: "The Shining",
            quantity: nil,
            created_at: Fri, 26 Jul 2024 09:46:40.507857000 UTC +00:00,
            updated_at: Sat, 27 Jul 2024 09:57:12.914858000 UTC +00:00,
            available_quantity: nil,
            author_id: 10,
            genre_id: 1>] 


      b) take
      The take method retrieves a record without any implicit ordering.
          Example:
        * 3.3.0 :489 > book = Book.take
            Book Load (0.4ms)  SELECT "books".* FROM "books" LIMIT $1  [["LIMIT", 1]]
          => 
          #<Book:0x0000000121470dc0
          ... 
          3.3.0 :490 > book
           => 
          #<Book:0x0000000121470dc0
           id: 2,
           isbn: nil,
           title: "Fundamental of physics",
           quantity: nil,
           created_at: Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00,
           updated_at: Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00,
           available_quantity: nil,
           author_id: 12,
           genre_id: 2>  

        * 3.3.0 :503 > author = Author.first(2)
           Author Load (1.2ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" ASC LIMIT $1  [["LIMIT", 2]]
          => 
          [#<Author:0x00000001219d7d18
         ... 
           3.3.0 :504 > author
          => 
          [#<Author:0x00000001219d7d18
           id: 8,
           author_name: "Nishchay",
           nationality: "Indian",
           created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
           updated_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
           books_count: 0>,
          #<Author:0x00000001219d7bd8
           id: 9,
           author_name: "Naman",
           nationality: "British",
           created_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
           updated_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
           books_count: 0>]

           
      c) first 
      The first method finds the first record ordered by primary key (default).
          Example:
        * 3.3.0 :491 > author = Author.first
            Author Load (0.8ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" ASC LIMIT $1  [["LIMIT", 1]]
          => 
          #<Author:0x0000000120a74128
          ... 
          3.3.0 :492 > author
           => 
          #<Author:0x0000000120a74128
           id: 8,
           author_name: "Nishchay",
           nationality: "Indian",
           created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
           updated_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
           books_count: 0>

           
      d) last
      The last method finds the last record ordered by primary key (default).
          Example:
        * 3.3.0 :493 > author = Author.last
            Author Load (0.8ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" DESC LIMIT $1  [["LIMIT", 1]]
          => 
          #<Author:0x00000001219d4898
          ... 
          3.3.0 :494 > author
           => 
          #<Author:0x00000001219d4898
           id: 13,
           author_name: "John Doe",
           nationality: "American",
           created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
           updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
           books_count: 2>

        * 3.3.0 :495 > author = Author.last(2)
           Author Load (1.3ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" DESC LIMIT $1  [["LIMIT", 2]]
          => 
          [#<Author:0x00000001219d1558
          ... 
          3.3.0 :496 > author
          => 
          [#<Author:0x00000001219d1558
           id: 12,
           author_name: "MS chauhan",
           nationality: "Indian",
           created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
           updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
           books_count: 1>,
          #<Author:0x00000001219d1698
           id: 13,
           author_name: "John Doe",
           nationality: "American",
           created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
           updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
           books_count: 2>] 


      e) find_by
      The find_by method finds the first record matching some conditions. 
            Example:
          * 3.3.0 :500 > Book.find_by(title:"Harry Potter and the Chamber of Secrets")
            Book Load (0.8ms)  SELECT "books".* FROM "books" WHERE "books"."title" = $1 LIMIT $2  [["title", "Harry Potter and the Chamber of Secrets"], ["LIMIT", 1]]
          => 
          #<Book:0x00000001219d1a58
           id: 6,
           isbn: nil,
           title: "Harry Potter and the Chamber of Secrets",
           quantity: nil,
           created_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
           updated_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
           available_quantity: nil,
           author_id: 10,
           genre_id: 2> 

        * 3.3.0 :502 > Book.find_by!(title:"s")
           Book Load (0.7ms)  SELECT "books".* FROM "books" WHERE "books"."title" = $1 LIMIT $2  [["title", "s"], ["LIMIT", 1]]
          (irb):502:in `<main>`: Couldnt find Book with [WHERE "books"."title" = $1] (ActiveRecord::RecordNotFound)


2) Retrieving Multiple Objects in Batches -> 
      a) find_each
      b) find_in_batches
