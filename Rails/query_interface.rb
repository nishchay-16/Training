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




====> CONDITIONS
The where method allows you to specify conditions to limit the records returned, representing the WHERE-part of the SQL statement. 
Conditions can either be specified as a string, array, or hash.

1) Pure String Conditions ->
      Example:
      3.3.0 :508 > Book.where("title = 'Harry Potter and the Prisoner of Azkaban'")
      Book Load (1.1ms)  SELECT "books".* FROM "books" WHERE (title = 'Harry Potter and the Prisoner of Azkaban') /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
      => 
      [#<Book:0x00000001219dd498
       id: 8,
       isbn: nil,
       title: "Harry Potter and the Prisoner of Azkaban",
       quantity: nil,
       created_at: Fri, 26 Jul 2024 09:32:51.669190000 UTC +00:00,
       updated_at: Fri, 26 Jul 2024 09:32:51.669190000 UTC +00:00,
       available_quantity: nil,
       author_id: 10,
       genre_id: 2>]


2) Array Conditions ->
      Example:
    * 3.3.0 :514 > params = {title: "Fundamental of physics"}
      => {:title=>"Fundamental of physics"} 
      3.3.0 :515 > Book.where("title = ?",params[:title])
       Book Load (1.8ms)  SELECT "books".* FROM "books" WHERE (title = 'Fundamental of physics') /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
      => 
      [#<Book:0x00000001219d99d8
       id: 2,
       isbn: nil,
       title: "Fundamental of physics",
       quantity: nil,
       created_at: Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00,
       updated_at: Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00,
       available_quantity: nil,
       author_id: 12,
       genre_id: 2>]

    a) Placeholder Conditions
        Example:
      *  3.3.0 :525 > params = { start_date: "Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00", end_date: "Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00" }
          => {:start_date=>"Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00", :end_date=>"Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00"} 
         3.3.0 :526 > start_date = DateTime.parse(params[:start_date])
         3.3.0 :527 > end_date = DateTime.parse(params[:end_date])
         3.3.0 :528 > 
          => Thu, 25 Jul 2024 10:27:46 +0000 
         3.3.0 :529 > books = Book.where("created_at >= :start_date AND created_at <= :end_date", { start_date: start_date, end_date: end_date })
           Book Load (2.6ms)  SELECT "books".* FROM "books" WHERE (created_at >= '2024-07-25 06:07:12.476305' AND created_at <= '2024-07-25 10:27:46.230403') /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
          => 
         [#<Book:0x0000000121a1ce40
         ... 
    
    b) Conditions That Use LIKE
        Example:
      * 3.3.0 :532 > params = {title: "Fundamental"}
        => {:title=>"Fundamental"} 
        3.3.0 :533 > Book.where("title LIKE ?", params[:title] + "%")
         Book Load (1.2ms)  SELECT "books".* FROM "books" WHERE (title LIKE 'Fundamental%') /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
        => 
        [#<Book:0x0000000121b1c318
         id: 2,
         isbn: nil,
         title: "Fundamental of physics",
         quantity: nil,
         created_at: Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00,
         updated_at: Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00,
         available_quantity: nil,
         author_id: 12,
         genre_id: 2>] 

  
3) Hash Conditions ->
  Active Record also allows you to pass in hash conditions which can increase the readability of your conditions syntax. 
  With hash conditions, you pass in a hash with keys of the fields you want qualified and the values of how you want to qualify them.
        
    a) Equality Conditions
        Example:
      * 3.3.0 :534 > Book.where(title: "Book Two")
        Book Load (0.6ms)  SELECT "books".* FROM "books" WHERE "books"."title" = $1 /* loading for pp */ LIMIT $2  [["title", "Book Two"], ["LIMIT", 11]]
         => 
        [#<Book:0x0000000121b74388
        id: 13,
        isbn: "0987654321",
        title: "Book Two",
        quantity: 10,
        created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        available_quantity: 10,
        author_id: 13,
        genre_id: 1>] 

      In the case of a belongs_to relationship, an association key can be used to specify the model if an Active Record object is used as the value. 
      This method works with polymorphic relationships as well.
      * 3.3.0 :541 > author = Author.last
          Author Load (2.2ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" DESC LIMIT $1  [["LIMIT", 1]]
          => 
          #<Author:0x0000000121b71cc8
        ... 
        3.3.0 :542 > Book.where(author: author)
          Book Load (0.9ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 /* loading for pp */ LIMIT $2  [["author_id", 13], ["LIMIT", 11]]
           => 
        [#<Book:0x00000001219dd5d8
          id: 12,
          isbn: "1234567890",
          title: "Book One",
          quantity: 5,
          created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          available_quantity: 5,
          author_id: 13,
          genre_id: 1>,
        #<Book:0x00000001219dd498
          id: 13,
          isbn: "0987654321",
          title: "Book Two",
          quantity: 10,
          created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          available_quantity: 10,
          author_id: 13,
          genre_id: 1>] 
        3.3.0 :543 > Author.joins(:books).where(books: { author: author })
        Author Load (1.1ms)  SELECT "authors".* FROM "authors" INNER JOIN "books" ON "books"."author_id" = "authors"."id" WHERE "books"."author_id" = $1 /* loading for pp */ LIMIT $2  [["author_id", 13], ["LIMIT", 11]]
         => 
        [#<Author:0x00000001219d3218
          id: 13,
          author_name: "John Doe",
          nationality: "American",
          created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          books_count: 2>,
        #<Author:0x00000001219d30d8
          id: 13,
          author_name: "John Doe",
          nationality: "American",
          created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          books_count: 2>] 

      Hash conditions may also be specified in a tuple-like syntax, where the key is an array of columns and the value is an array of tuples:
      * 3.3.0 :545 > Book.where([:author_id, :id] => [[13, 12], [13, 13]])
          Book Load (1.1ms)  SELECT "books".* FROM "books" WHERE ("books"."author_id" = $1 AND "books"."id" = $2 OR "books"."author_id" = $3 AND "books"."id" = $4) /* loading for pp */ LIMIT $5  [["author_id", 13], ["id", 12], ["author_id", 13], ["id", 13], ["LIMIT", 11]]
         => 
        [#<Book:0x0000000121ade108
          id: 12,
          isbn: "1234567890",
          title: "Book One",
          quantity: 5,
          created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          available_quantity: 5,
          author_id: 13,
          genre_id: 1>,
         #<Book:0x0000000121addfc8
          id: 13,
          isbn: "0987654321",
          title: "Book Two",
          quantity: 10,
          created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          available_quantity: 10,
          author_id: 13,
          genre_id: 1>] 
        

    b) Subset Conditions -> If you want to find records using the IN expression you can pass an array to the conditions hash:
        Example:
      * 3.3.0 :548 > Author.where(books_count: [1,3,5])
          Author Load (1.4ms)  SELECT "authors".* FROM "authors" WHERE "authors"."books_count" IN ($1, $2, $3) /* loading for pp */ LIMIT $4  [["books_count", 1], ["books_count", 3], ["books_count", 5], ["LIMIT", 11]]
         => 
        [#<Author:0x00000001219db058
          id: 10,
          author_name: "J.K. Rowling",
          nationality: "British",
          created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
          updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
          books_count: 5>,
         #<Author:0x00000001219daf18
          id: 12,
          author_name: "MS chauhan",
          nationality: "Indian",
          created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
          updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
          books_count: 1>] 
         