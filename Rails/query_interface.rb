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
        

    b) Range Conditions
        Example:
      * 3.3.0 :552 > Book.where(created_at: (Time.now.midnight - 2.day)..Time.now.midnight)
          Book Load (0.8ms)  SELECT "books".* FROM "books" WHERE "books"."created_at" BETWEEN $1 AND $2 /* loading for pp */ LIMIT $3  [["created_at", "2024-07-26 18:30:00"], ["created_at", "2024-07-28 18:30:00"], ["LIMIT", 11]]
         => 
        [#<Book:0x000000012147adc0
          id: 12,
          isbn: "1234567890",
          title: "Book One",
          quantity: 5,
          created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
          available_quantity: 5,
          author_id: 13,
          genre_id: 1>,
         #<Book:0x000000012147ac80
          id: 13,
          isbn: "0987654321",
          title: "Book Two",
          quantity: 10,
          created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
          available_quantity: 10,
          author_id: 13,
          genre_id: 1>] 
        

    c) Subset Conditions    
     If you want to find records using the IN expression you can pass an array to the conditions hash:
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
         

  4) NOT Conditions ->
      Example:
    * 3.3.0 :553 > Author.where.not(books_count: [1,3,5])
        Author Load (1.8ms)  SELECT "authors".* FROM "authors" WHERE "authors"."books_count" NOT IN ($1, $2, $3) /* loading for pp */ LIMIT $4  [["books_count", 1], ["books_count", 3], ["books_count", 5], ["LIMIT", 11]]
       => 
      [#<Author:0x00000001219d0798
        id: 8,
        author_name: "Nishchay",
        nationality: "Indian",
        created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
        updated_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
        books_count: 0>,
       #<Author:0x00000001219d0658
        id: 9,
        author_name: "Naman",
        nationality: "British",
        created_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
        updated_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
        books_count: 0>,
       #<Author:0x00000001219d0518
        id: 11,
        author_name: "HC Verma",
        nationality: "Indian",
        created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
        updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
        books_count: 0>,
       #<Author:0x00000001219d03d8
        id: 13,
        author_name: "John Doe",
        nationality: "American",
        created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
        books_count: 2>] 

    
  5) OR Conditions ->
      Example:
    * 3.3.0 :556 > Author.where(nationality: "Indian").or(Author.where(books_count: [1,3,5]))
      Author Load (2.8ms)  SELECT "authors".* FROM "authors" WHERE ("authors"."nationality" = $1 OR "authors"."books_count" IN ($2, $3, $4)) /* loading for pp */ LIMIT $5  [["nationality", "Indian"], ["books_count", 1], ["books_count", 3], ["books_count", 5], ["LIMIT", 11]]
       => 
     #<Author:0x0000000121b7ac88
      id: 8,
      author_name: "Nishchay",
      nationality: "Indian",
      created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
      updated_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
      books_count: 0>,
     #<Author:0x0000000121b7ab48
      id: 11,
      author_name: "HC Verma",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      books_count: 0>,
     #<Author:0x0000000121b7aa08
      id: 10,
      author_name: "J.K. Rowling",
      nationality: "British",
      created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
      updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
      books_count: 5>,
     #<Author:0x0000000121b7a8c8
      id: 12,
      author_name: "MS chauhan",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      books_count: 1>]


  6) AND Conditions ->
      Example:
    * 3.3.0 :557 > Author.where(nationality: "Indian").where(books_count: [1,3,5])
        Author Load (1.0ms)  SELECT "authors".* FROM "authors" WHERE "authors"."nationality" = $1 AND "authors"."books_count" IN ($2, $3, $4) /* loading for pp */ LIMIT $5  [["nationality", "Indian"], ["books_count", 1], ["books_count", 3], ["books_count", 5], ["LIMIT", 11]]
       => 
      [#<Author:0x0000000120d3a290
        id: 12,
        author_name: "MS chauhan",
        nationality: "Indian",
        created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
        updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
        books_count: 1>] 



====> ORDERING 
To retrieve records from the database in a specific order, you can use the order method.

      Example:
    * 3.3.0 :563 > Author.order(created_at: :desc)         # Author.order("created_at DESC")
      Author Load (0.9ms)  SELECT "authors".* FROM "authors" /* loading for pp */ ORDER BY "authors"."created_at" DESC LIMIT $1  [["LIMIT", 11]]
     => 
    [#<Author:0x0000000121b58fc0
      id: 13,
      author_name: "John Doe",
      nationality: "American",
      created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
      updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
      books_count: 2>,
     #<Author:0x0000000121b58e80
      id: 12,
      author_name: "MS chauhan",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      books_count: 1>,
     #<Author:0x0000000121b58d40
      id: 11,
      author_name: "HC Verma",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      books_count: 0>]

    * 3.3.0 :564 > Author.order(created_at: :asc)        # Author.order("created_at ASC")
      Author Load (0.4ms)  SELECT "authors".* FROM "authors" /* loading for pp */ ORDER BY "authors"."created_at" ASC LIMIT $1  [["LIMIT", 11]]
     => 
     #<Author:0x0000000121b7bcc8
      id: 11,
      author_name: "HC Verma",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
      books_count: 0>,
     #<Author:0x0000000121b7bb88
      id: 12,
      author_name: "MS chauhan",
      nationality: "Indian",
      created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
      books_count: 1>,
     #<Author:0x0000000121b7ba48
      id: 13,
      author_name: "John Doe",
      nationality: "American",
      created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
      updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
      books_count: 2>] 

    * 3.3.0 :565 > Author.order("author_name ASC, created_at DESC")       # Author.order(author_name: :asc, created_at: :desc)
      3.3.0 :566 > 
        Author Load (1.1ms)  SELECT "authors".* FROM "authors" /* loading for pp */ ORDER BY author_name ASC, created_at DESC LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Author:0x0000000121b7bcc8
        id: 11,
        author_name: "HC Verma",
        nationality: "Indian",
        created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
        updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
        books_count: 0>,
       #<Author:0x0000000121b7ba48
        id: 13,
        author_name: "John Doe",
        nationality: "American",
        created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
        books_count: 2>,
       #<Author:0x0000000121b7b908
        id: 12,
        author_name: "MS chauhan",
        nationality: "Indian",
        created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
        updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
        books_count: 1>]

      

===> SELECTING SPECIFIC FIELDS 
By default, Model.find selects all the fields from the result set using select *.
To select only a subset of fields from the result set, you can specify the subset via the select method.

  Example:
  * 3.3.0 :568 > Book.select(:id, :title)
      Book Load (0.4ms)  SELECT "books"."id", "books"."title" FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
     => 
    [#<Book:0x0000000121b7bb88 id: 2, title: "Fundamental of physics">,
     #<Book:0x0000000121b7ba48 id: 6, title: "Harry Potter and the Chamber of Secrets">,
     #<Book:0x0000000121b7b908 id: 7, title: "Harry Potter and the Philosopher's Stone">,
     #<Book:0x0000000121b7b7c8 id: 8, title: "Harry Potter and the Prisoner of Azkaban">,
     #<Book:0x0000000121b7b688 id: 9, title: "The Casual Vacancy">,
     #<Book:0x0000000121b7b548 id: 10, title: "The Shining">,
     #<Book:0x0000000121b7b408 id: 12, title: "Book One">,
     #<Book:0x0000000121b7b2c8 id: 13, title: "Book Two">]
                      
  * 3.3.0 :569 > Book.select(:id, :title).last(2)
     Book Load (0.5ms)  SELECT "books"."id", "books"."title" FROM "books" ORDER BY "books"."id" DESC LIMIT $1  [["LIMIT", 2]]
    => [#<Book:0x00000001219da3d8 id: 12, title: "Book One">, #<Book:0x00000001219da518 id: 13, title: "Book Two">] 



===> LIMIT AND OFFSET
To apply LIMIT to the SQL fired by the Model.find, you can specify the LIMIT using limit and offset methods on the relation.
You can use limit to specify the number of records to be retrieved, and use offset to specify the number of records to skip before starting to return the records.

  Example:
  * 3.3.0 :570 > Book.limit(3)
      Book Load (1.5ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 3]]
     => 
    [#<Book:0x0000000121b50780
      id: 2,
      isbn: nil,
      title: "Fundamental of physics",
      quantity: nil,
      created_at: Thu, 25 Jul 2024 06:07:12.476305000 UTC +00:00,
      updated_at: Thu, 25 Jul 2024 10:27:46.230403000 UTC +00:00,
      available_quantity: nil,
      author_id: 12,
      genre_id: 2>,
     #<Book:0x0000000121b50640
      id: 6,
      isbn: nil,
      title: "Harry Potter and the Chamber of Secrets",
      quantity: nil,
      created_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
      updated_at: Fri, 26 Jul 2024 09:32:11.673499000 UTC +00:00,
      available_quantity: nil,
      author_id: 10,
      genre_id: 2>,
     #<Book:0x0000000121b50500
      id: 7,
      isbn: nil,
      title: "Harry Potter and the Philosopher's Stone",
      quantity: nil,
      created_at: Fri, 26 Jul 2024 09:32:36.509940000 UTC +00:00,
      updated_at: Fri, 26 Jul 2024 09:32:36.509940000 UTC +00:00,
      available_quantity: nil,
      author_id: 10,
      genre_id: 2>] 

  * 3.3.0 :574 > Book.limit(3).offset(2)
      Book Load (0.6ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1 OFFSET $2  [["LIMIT", 3], ["OFFSET", 2]]
     => 
    [#<Book:0x00000001219d1558
      id: 7,
      isbn: nil,
      title: "Harry Potter and the Philosopher's Stone",
      quantity: nil,
      created_at: Fri, 26 Jul 2024 09:32:36.509940000 UTC +00:00,
      updated_at: Fri, 26 Jul 2024 09:32:36.509940000 UTC +00:00,
      available_quantity: nil,
      author_id: 10,
      genre_id: 2>,
     #<Book:0x00000001219d1418
      id: 8,
      isbn: nil,
      title: "Harry Potter and the Prisoner of Azkaban",
      quantity: nil,
      created_at: Fri, 26 Jul 2024 09:32:51.669190000 UTC +00:00,
      updated_at: Fri, 26 Jul 2024 09:32:51.669190000 UTC +00:00,
      available_quantity: nil,
      author_id: 10,
      genre_id: 2>,
     #<Book:0x00000001219d12d8
      id: 9,
      isbn: nil,
      title: "The Casual Vacancy",
      quantity: nil,
      created_at: Fri, 26 Jul 2024 09:46:40.502867000 UTC +00:00,
      updated_at: Fri, 26 Jul 2024 09:46:40.502867000 UTC +00:00,
      available_quantity: nil,
      author_id: 10,
      genre_id: 1>] 




====> GROUPING 
To apply a GROUP BY clause to the SQL fired by the finder, you can use the group method.
Example:
  3.3.0 :575 > Book.select("author_id").group("author_id")
  Book Load (0.9ms)  SELECT "books"."author_id" FROM "books" GROUP BY "books"."author_id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
 => 
[#<Book:0x00000001219d6698 id: nil, author_id: 10>,
 #<Book:0x00000001219d6558 id: nil, author_id: 12>,
 #<Book:0x00000001219d6418 id: nil, author_id: 13>] 

    1) Total of Grouped Items ->
      To get the total of grouped items on a single query, call count after the group.
        Example:
        * 3.3.0 :576 > Book.group("author_id").count
          Book Count (1.8ms)  SELECT COUNT(*) AS "count_all", "books"."author_id" AS "books_author_id" FROM "books" GROUP BY "books"."author_id"
         => {10=>5, 13=>2, 12=>1} 
        
    2) HAVING Conditions ->
    SQL uses the HAVING clause to specify conditions on the GROUP BY fields. 
    We can add the HAVING clause to the SQL fired by the Model.find by adding the having method to the find.
      Example:
      * 3.3.0 :623 > min_total_quantity = 3
          => 3 
         3.3.0 :624 > authors_with_big_book_quantities = Book.select("author_id, sum(quantity) as total_quantity")
         3.3.0 :625 >                                        .group("author_id")
         3.3.0 :626 >                                        .having("sum(quantity) > ?", min_total_quantity)
           Book Load (1.3ms)  SELECT author_id, sum(quantity) as total_quantity FROM "books" GROUP BY "books"."author_id" HAVING (sum(quantity) > 3) /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
          => [#<Book:0x00000001219de398 id: nil, author_id: 13>] 



====> OVERRIDING CONDITIONS
  
  1) unscope -> You can specify certain conditions to be removed using the unscope method.
      Example:
      3.3.0 :637 > books = Book.where(available_quantity: 10).order(:title).unscope(:order)
        Book Load (0.6ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 10], ["LIMIT", 11]]
       => 
      [#<Book:0x0000000121afcbd0
      ... 
      3.3.0 :638 > books
        Book Load (0.6ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 10], ["LIMIT", 11]]
       => 
      [#<Book:0x00000001219d4ed8
        id: 13,
        isbn: "0987654321",
        title: "Book Two",
        quantity: 10,
        created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        available_quantity: 10,
        author_id: 13,
        genre_id: 1>] 


  2) only -> You can also override conditions using the only method.
      Example:
      3.3.0 :639 > books = Book.where(available_quantity: 10).order(:title).only(:where)
        Book Load (2.1ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 10], ["LIMIT", 11]]
       => 
      [#<Book:0x0000000121b57800
      ... 
      3.3.0 :640 > books
        Book Load (0.7ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 10], ["LIMIT", 11]]
       => 
      [#<Book:0x0000000121b3b560
        id: 13,
        isbn: "0987654321",
        title: "Book Two",
        quantity: 10,
        created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
        available_quantity: 10,
        author_id: 13,
        genre_id: 1>] 


  3) reselect -> The reselect method overrides an existing select statement. 
      Example:
      3.3.0 :641 > books = Book.select(:title, :quantity).reselect(:isbn, :author_id)
        Book Load (0.5ms)  SELECT "books"."isbn", "books"."author_id" FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Book:0x0000000121afe4d0 id: nil, isbn: nil, author_id: 12>,
      ... 
      3.3.0 :642 > books
        Book Load (0.5ms)  SELECT "books"."isbn", "books"."author_id" FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Book:0x0000000121ad5788 id: nil, isbn: nil, author_id: 12>,
       #<Book:0x0000000121ad5648 id: nil, isbn: nil, author_id: 10>,
       #<Book:0x0000000121ad5508 id: nil, isbn: nil, author_id: 10>,
       #<Book:0x0000000121ad53c8 id: nil, isbn: nil, author_id: 10>,
       #<Book:0x0000000121ad5288 id: nil, isbn: nil, author_id: 10>,
       #<Book:0x0000000121ad5148 id: nil, isbn: nil, author_id: 10>,
       #<Book:0x0000000121ad5008 id: nil, isbn: "1234567890", author_id: 13>,
       #<Book:0x0000000121ad4ec8 id: nil, isbn: "0987654321", author_id: 13>] 


  4) reorder -> The reorder method overrides the default scope order. 
      Example:
      3.3.0 :647 > genres = Genre.order(:genre_name).reorder(:created_at)
        Genre Load (0.5ms)  SELECT "genres".* FROM "genres" /* loading for pp */ ORDER BY "genres"."created_at" ASC LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Genre:0x00000001219dbb98
      ... 
      3.3.0 :648 > genres
        Genre Load (0.6ms)  SELECT "genres".* FROM "genres" /* loading for pp */ ORDER BY "genres"."created_at" ASC LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Genre:0x00000001219d26d8
        id: 1,
        genre_name: "horror",
        created_at: Tue, 23 Jul 2024 11:45:37.705157000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:48:15.987849000 UTC +00:00>,
       #<Genre:0x00000001219d2598
        id: 2,
        genre_name: "fantasy",
        created_at: Tue, 23 Jul 2024 12:11:57.817350000 UTC +00:00,
        updated_at: Tue, 23 Jul 2024 12:11:57.817350000 UTC +00:00>] 


  5) reverse_order -> The reverse_order method reverses the ordering clause if specified.
      Example:
      3.3.0 :649 > genres = Genre.order(:genre_name).reverse_order
        Genre Load (1.0ms)  SELECT "genres".* FROM "genres" /* loading for pp */ ORDER BY "genres"."genre_name" DESC LIMIT $1  [["LIMIT", 11]]
       => 
      [#<Genre:0x00000001219d8d58
      ... 

          
  6) rewhere -> The rewhere method overrides an existing, named where condition.
      Example:
      3.3.0 :651 > books = Book.where(available_quantity: 10).rewhere(available_quantity: 5)
        Book Load (2.0ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 5], ["LIMIT", 11]]
       => 
      [#<Book:0x0000000121b71688
      ... 
      3.3.0 :652 > books
        Book Load (0.6ms)  SELECT "books".* FROM "books" WHERE "books"."available_quantity" = $1 /* loading for pp */ LIMIT $2  [["available_quantity", 5], ["LIMIT", 11]]
       => 
      [#<Book:0x0000000121b58d40
        id: 12,
        isbn: "1234567890",
        title: "Book One",
        quantity: 5,
        created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
        updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
        available_quantity: 5,
        author_id: 13,
        genre_id: 1>] 


  7) regroup -> The regroup method overrides an existing, named group condition. 
      Example:
      3.3.0 :653 > books = Book.select("genre_id, sum(quantity) as total_quantity")
      3.3.0 :654 >             .group(:genre_id)
      3.3.0 :655 >             .regroup(:author_id)
        Book Load (4.3ms)  SELECT genre_id, sum(quantity) as total_quantity FROM "books" GROUP BY "books"."author_id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
              


====> NULL RELATION
The none method returns a chainable relation with no records. 
Any subsequent conditions chained to the returned relation will continue generating empty relations. 
This is useful in scenarios where you need a chainable response to a method or a scope that could return zero results.
  Example:
    3.3.0 :658 > Book.none
      => [] 


  
====> READONLY OBJECTS
Active Record provides the readonly method on a relation to explicitly disallow modification of any of the returned objects. 
Any attempt to alter a readonly record will not succeed, raising an ActiveRecord::ReadOnlyRecord exception.
  Example:
  3.3.0 :662 > book = Book.readonly.last
    Book Load (0.4ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT $1  [["LIMIT", 1]]
   => 
  #<Book:0x00000001219d5018
  ... 
  3.3.0 :663 > book.available_quantity += 1
   => 11 
  3.3.0 :664 > book.save
  (irb):664:in `<main>`: Book is marked as readonly (ActiveRecord::ReadOnlyRecord)




====> LOCKING RECORDS FOR UPDATE
Locking is helpful for preventing race conditions when updating records in the database and ensuring atomic updates.
Active Record provides two locking mechanisms:
  1) Optimistic Locking ->
     Optimistic locking allows multiple users to access the same record for edits, and assumes a minimum of conflicts with the data. 
     It does this by checking whether another process has made changes to a record since it was opened.
        a) Optimistic locking column
            Example:
            3.3.0 :719 > a1.author_name = "Nishu"
            3.3.0 :720 > a1.save
            3.3.0 :721 > 
              TRANSACTION (0.4ms)  BEGIN
              Author Update (1.6ms)  UPDATE "authors" SET "author_name" = $1, "updated_at" = $2, "lock_version" = $3 WHERE "authors"."id" = $4 AND "authors"."lock_version" = $5  [["author_name", "Nishu"], ["updated_at", "2024-07-29 09:43:57.658739"], ["lock_version", 3], ["id", 8], ["lock_version", 2]]
              TRANSACTION (1.8ms)  COMMIT
             => true 
            3.3.0 :725 > puts "a1.lock_version: #{a1.lock_version}"  
            a1.lock_version: 3
             => nil 
            3.3.0 :726 > a2.author_name = "Vaibhav"
            3.3.0 :727 > begin
            3.3.0 :728 >   a2.save
            3.3.0 :729 > rescue ActiveRecord::StaleObjectError => e
            3.3.0 :730 >   puts "Attempt to update stale object: #{e.message}"
            3.3.0 :731 > end
             => true 
            3.3.0 :732 > a1.reload
            3.3.0 :733 > puts "a1.lock_version after reload: #{a1.lock_version}"
            3.3.0 :734 > 
              Author Load (0.4ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 8], ["LIMIT", 1]]
            a1.lock_version after reload: 3
             => nil 
            
  2) Pessimistic Locking ->
      Pessimistic locking uses a locking mechanism provided by the underlying database. 
      Using lock when building a relation obtains an exclusive lock on the selected rows. Relations using lock are usually wrapped inside a transaction for preventing deadlock conditions.

        Example:
          3.3.0 :735 > Book.transaction do
          3.3.0 :736 >   book = Book.lock.first
          3.3.0 :737 >   book.title = 'Algorithms, second edition'
          3.3.0 :738 >   book.save!
          3.3.0 :739 > end
            TRANSACTION (0.4ms)  BEGIN
            Book Load (0.9ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" ASC LIMIT $1 FOR UPDATE  [["LIMIT", 1]]
            Book Update (1.7ms)  UPDATE "books" SET "title" = $1, "updated_at" = $2 WHERE "books"."id" = $3  [["title", "Algorithms, second edition"], ["updated_at", "2024-07-29 09:45:27.027350"], ["id", 2]]
            Genre Load (0.3ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
            Author Load (0.2ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 12], ["LIMIT", 1]]
            Book Count (0.4ms)  SELECT COUNT(*) FROM "books" WHERE "books"."author_id" = $1  [["author_id", 12]]
            Genre Update (0.4ms)  UPDATE "genres" SET "updated_at" = $1 WHERE "genres"."id" = $2  [["updated_at", "2024-07-29 09:45:27.040296"], ["id", 2]]
          Book/Genre was touched
            TRANSACTION (1.3ms)  COMMIT
           => true 
          


====> JOINING TABLES  
Active Record provides two finder methods for specifying JOIN clauses on the resulting SQL: joins and left_outer_joins. 
While joins should be used for INNER JOIN or custom queries, left_outer_joins is used for queries using LEFT OUTER JOIN.

    1) Joins -> There are multiple ways to use the joins method.
        a) Using a String SQL Fragment :-> You can just supply the raw SQL specifying the JOIN clause to joins.
          Example:
          3.3.0 :767 > Author.joins("INNER JOIN books ON books.author_id = authors.id AND books.id > 5")
            Author Load (1.8ms)  SELECT "authors".* FROM "authors" INNER JOIN books ON books.author_id = authors.id AND books.id > 5
             /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
           => 
          [#<Author:0x0000000121b70788
            id: 10,
            author_name: "J.K. Rowling",
            nationality: "British",
            created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            books_count: 5,
            lock_version: 0>,
           #<Author:0x0000000121b70648
            id: 10,
            author_name: "J.K. Rowling",
            nationality: "British",
            created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            books_count: 5,
            lock_version: 0>,
           #<Author:0x0000000121b70508
            id: 10,
            author_name: "J.K. Rowling",
            nationality: "British",
            created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            books_count: 5,
            lock_version: 0>,
           #<Author:0x0000000121b703c8
            id: 10,
            author_name: "J.K. Rowling",
            nationality: "British",
            created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            books_count: 5,
            lock_version: 0>,
           #<Author:0x0000000121b70288
            id: 10,
            author_name: "J.K. Rowling",
            nationality: "British",
            created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
            books_count: 5,
            lock_version: 0>,
           #<Author:0x0000000121b70148
            id: 13,
            author_name: "John Doe",
            nationality: "American",
            created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
            updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
            books_count: 2,
            lock_version: 0>,
           #<Author:0x0000000121b70008
            id: 13,
            author_name: "John Doe",
            nationality: "American",
            created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
            updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
            books_count: 2,
            lock_version: 0>] 

        b) Using Array/Hash of Named Associations :-> 
            Example:
            3.3.0 :769 > Book.joins(:author)
            Book Load (3.8ms)  SELECT "books".* FROM "books" INNER JOIN "authors" ON "authors"."id" = "books"."author_id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]

        c) Joining Multiple Associations
            Example:
            3.3.0 :771 > Book.joins(:author, :genre)
            Book Load (2.4ms)  SELECT "books".* FROM "books" INNER JOIN "authors" ON "authors"."id" = "books"."author_id" INNER JOIN 
            "genres" ON "genres"."id" = "books"."genre_id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]

            * Joining Nested Associations (Single Level)
              Example:
              3.3.0 :055 > Transaction.joins(book: :author)
              3.3.0 :056 > 
                Transaction Load (2.6ms)  SELECT "transactions".* FROM "transactions" INNER JOIN "books" ON "books"."id" = "transactions"."book_id" 
                INNER JOIN "authors" ON "authors"."id" = "books"."author_id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
               => 
              [#<Transaction:0x000000012d757be0
                id: 10,
                member_id: 2,
                isbn: "1234567890",
                issuedate: Mon, 29 Jul 2024,
                returndate: Mon, 12 Aug 2024,
                created_at: Mon, 29 Jul 2024 10:14:42.834489000 UTC +00:00,
                updated_at: Mon, 29 Jul 2024 10:14:42.834489000 UTC +00:00,
                book_id: 15,
                librarian_id: 16>]

            * Joining Nested Associations (Multiple Level)
              Example:
              3.3.0 :065 > transactions = Transaction.joins(book: [:author, :genre])
              3.3.0 :066 >                           .joins(:member)
              3.3.0 :067 >                           .joins(:librarian)
              3.3.0 :068 >                           .select(
              3.3.0 :069'>                             'transactions.*, 
              3.3.0 :070'>                              books.title AS book_title, 
              3.3.0 :071'>                              authors.author_name AS author_name, 
              3.3.0 :072'>                              genres.genre_name AS genre_name, 
              3.3.0 :073'>                              members.member_name AS member_name, 
              3.3.0 :074 >                              librarians.librarian_name AS librarian_name
              3.3.0 :075 >                           )
                Transaction Load (8.2ms)  SELECT transactions.*, 
                                           books.title AS book_title, 
                                           authors.author_name AS author_name, 
                                           genres.genre_name AS genre_name, 
                                           members.member_name AS member_name, 
                                           librarians.librarian_name AS librarian_name FROM "transactions" INNER JOIN "books" ON "books"."id" = "transactions"."book_id" 
                                           INNER JOIN "authors" ON "authors"."id" = "books"."author_id" INNER JOIN "genres" ON "genres"."id" = "books"."genre_id" INNER JOIN 
                                           "members" ON "members"."id" = "transactions"."member_id" INNER JOIN "librarians" ON "librarians"."id" = "transactions"."librarian_id"
                                            /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
               => 
              [#<Transaction:0x00000001029b08e0

        d) Specifying Conditions on the Joined Tables
            Example:      
            3.3.0 :087 >  transactions = Transaction.joins(:book).where(created_at: time_range).select('transactions.*, books.title AS book_title').distinct
            3.3.0 :088 > 
              Transaction Load (24.5ms)  SELECT DISTINCT transactions.*, books.title AS book_title FROM "transactions" INNER JOIN "books" ON 
                                         "books"."id" = "transactions"."book_id" WHERE "transactions"."created_at" BETWEEN $1 AND $2 /* loading 
                                         for pp */ LIMIT $3  [["created_at", "2024-07-27 18:30:00"], ["created_at", "2024-07-28 18:30:00"], ["LIMIT", 11]]
              
    
    2) Left_outer_joins -> 
        Example:
        3.3.0 :092 > Author.left_outer_joins(:books).select('authors.*, COUNT(books.id) AS books_count').group('authors.id')
          Author Load (2.8ms)  SELECT authors.*, COUNT(books.id) AS books_count FROM "authors" LEFT OUTER JOIN "books" ON 
                              "books"."author_id" = "authors"."id" GROUP BY "authors"."id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
         => 
        [#<Author:0x000000012e7bd980
          id: 8,
          author_name: "Nishu",
          nationality: "Indian",
          created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 09:43:57.658739000 UTC +00:00,
          books_count: 0,
          lock_version: 3>,
         #<Author:0x000000012e7bd840
          id: 9,
          author_name: "Naman",
          nationality: "British",
          created_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
          updated_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
          books_count: 0,
          lock_version: 0>,
         #<Author:0x000000012e7bd700
          id: 10,
          author_name: "J.K. Rowling",
          nationality: "British",
          created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
          updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
          books_count: 5,
          lock_version: 0>,
         #<Author:0x000000012e7bd5c0
          id: 11,
          author_name: "HC Verma",
          nationality: "Indian",
          created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
          updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
          books_count: 0,
          lock_version: 0>,
         #<Author:0x000000012e7bd480
          id: 12,
          author_name: "MS chauhan",
          nationality: "Indian",
          created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
          updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
          books_count: 1,
          lock_version: 0>,
         #<Author:0x000000012e7bd340
          id: 13,
          author_name: "John Doe",
          nationality: "American",
          created_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 10:47:49.391915000 UTC +00:00,
          books_count: 2,
          lock_version: 0>,
         #<Author:0x000000012e7bd200
          id: 14,
          author_name: "Sample Author",
          nationality: "Sample Nationality",
          created_at: Mon, 29 Jul 2024 10:09:06.078369000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 10:09:06.078369000 UTC +00:00,
          books_count: 1,
          lock_version: 1>,
         #<Author:0x000000012e7bd0c0
          id: 15,
          author_name: "Sample Author",
          nationality: "Sample Nationality",
          created_at: Mon, 29 Jul 2024 10:13:45.535694000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 10:13:45.535694000 UTC +00:00,
          books_count: 1,
          lock_version: 1>] 

    3) Where.associated and where.missing
        Example:
        3.3.0 :096 > Genre.where.associated(:books)
          Genre Load (0.8ms)  SELECT "genres".* FROM "genres" INNER JOIN "books" ON "books"."genre_id" = "genres"."id" WHERE "books"."id" IS NOT NULL /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
         => 
        [#<Genre:0x000000012e7fd210
          id: 1,
          genre_name: "horror",
          created_at: Tue, 23 Jul 2024 11:45:37.705157000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 10:13:49.388465000 UTC +00:00>,
         #<Genre:0x000000012e7fd0d0
          id: 1,
          genre_name: "horror",
          created_at: Tue, 23 Jul 2024 11:45:37.705157000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 10:13:49.388465000 UTC +00:00>,
         #<Genre:0x000000012e7fcf90
          id: 1,
          genre_name: "horror",
          created_at: Tue, 23 Jul 2024 11:45:37.705157000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 10:13:49.388465000 UTC +00:00>,
         #<Genre:0x000000012e7fc810
          id: 2,
          genre_name: "fantasy",
          created_at: Tue, 23 Jul 2024 12:11:57.817350000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 09:45:27.040296000 UTC +00:00>,
         #<Genre:0x000000012e7fc590
          id: 2,
          genre_name: "fantasy",
          created_at: Tue, 23 Jul 2024 12:11:57.817350000 UTC +00:00,
          updated_at: Mon, 29 Jul 2024 09:45:27.040296000 UTC +00:00>] 




=====> EAGER LOADING ASSOCIATIONS
Eager loading is the mechanism for loading the associated records of the objects returned by Model.find using as few queries as possible.
  
  1) N + 1 Queries Problem
      Example:
      3.3.0 :097 > books = Book.limit(4)
      3.3.0 :098 > 
        Book Load (1.9ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 4]]
       => 
      [#<Book:0x000000012e7ff650
      ... 
      3.3.0 :099 > books.each do |book|
      3.3.0 :100 >   puts book.author.author_name
      3.3.0 :101 > end
        Book Load (0.4ms)  SELECT "books".* FROM "books" LIMIT $1  [["LIMIT", 4]]
        Author Load (0.3ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
      J.K. Rowling
        Author Load (0.2ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
      J.K. Rowling
        Author Load (0.1ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
      J.K. Rowling
        Author Load (0.1ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
      J.K. Rowling


  2) includes -> With includes, Active Record ensures that all of the specified associations are loaded using the minimum possible number of queries.
      Example:
      3.3.0 :102 > books = Book.includes(:author).limit(4)
        Book Load (1.7ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 4]]
        Author Load (0.7ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1  [["id", 10]]
       => 
      [#<Book:0x000000012e7d5788
      ... 
      3.3.0 :103 > books.each do |book|
      3.3.0 :104 >   puts book.author.author_name
      3.3.0 :105 > end
        Book Load (0.7ms)  SELECT "books".* FROM "books" LIMIT $1  [["LIMIT", 4]]
        Author Load (0.2ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1  [["id", 10]]
      J.K. Rowling
      J.K. Rowling
      J.K. Rowling
      J.K. Rowling

          a) Eager Loading Multiple Associations
              Example:
              3.3.0 :108 > Book.includes(:genre, :author)
              Book Load (0.9ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
              Genre Load (1.4ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" IN ($1, $2)  [["id", 2], ["id", 1]]
              Author Load (0.6ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" IN ($1, $2, $3, $4, $5)  [["id", 10], ["id", 13], ["id", 12], ["id", 14], ["id", 15]]

          b) Specifying Conditions on Eager Loaded Associations
              Example:
              3.3.0 :110 > Author.includes(:books).where(books: {quantity: nil})
                SQL (2.0ms)  SELECT DISTINCT "authors"."id" FROM "authors" LEFT OUTER JOIN "books" ON "books"."author_id" = "authors"."id" WHERE "books"."quantity" IS NULL /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
                SQL (1.1ms)  SELECT "authors"."id" AS t0_r0, "authors"."author_name" AS t0_r1, "authors"."nationality" AS t0_r2,
                 "authors"."created_at" AS t0_r3, "authors"."updated_at" AS t0_r4, "authors"."books_count" AS t0_r5, "authors"."lock_version"
                  AS t0_r6, "books"."id" AS t1_r0, "books"."isbn" AS t1_r1, "books"."title" AS t1_r2, "books"."quantity" AS t1_r3, "books"."created_at" 
                  AS t1_r4, "books"."updated_at" AS t1_r5, "books"."available_quantity" AS t1_r6, "books"."author_id" AS t1_r7, "books"."genre_id" AS
                   t1_r8 FROM "authors" LEFT OUTER JOIN "books" ON "books"."author_id" = "authors"."id" WHERE "books"."quantity" IS NULL AND "authors"."id" 
                   IN ($1, $2, $3, $4, $5) /* loading for pp */  [["id", 8], ["id", 9], ["id", 10], ["id", 11], ["id", 12]]
               => 
              [#<Author:0x000000012e7f8490
                id: 10,
                author_name: "J.K. Rowling",
                nationality: "British",
                created_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
                updated_at: Wed, 24 Jul 2024 06:00:42.555280000 UTC +00:00,
                books_count: 5,
                lock_version: 0>,
               #<Author:0x000000012e7f7d10
                id: 12,
                author_name: "MS chauhan",
                nationality: "Indian",
                created_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
                updated_at: Thu, 25 Jul 2024 10:23:50.376919000 UTC +00:00,
                books_count: 1,
                lock_version: 0>,
               #<Author:0x000000012e7f7a90
                id: 11,
                author_name: "HC Verma",
                nationality: "Indian",
                created_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
                updated_at: Thu, 25 Jul 2024 10:18:32.629404000 UTC +00:00,
                books_count: 0,
                lock_version: 0>,
               #<Author:0x000000012e7f7950
                id: 8,
                author_name: "Nishu",
                nationality: "Indian",
                created_at: Fri, 19 Jul 2024 13:12:53.713149000 UTC +00:00,
                updated_at: Mon, 29 Jul 2024 09:43:57.658739000 UTC +00:00,
                books_count: 0,
                lock_version: 3>,
               #<Author:0x000000012e7f7810
                id: 9,
                author_name: "Naman",
                nationality: "British",
                created_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
                updated_at: Fri, 19 Jul 2024 13:12:53.715259000 UTC +00:00,
                books_count: 0,
                lock_version: 0>]
                                 
      
  3) preload -> With preload, Active Record loads each specified association using one query per association.
      Example:
      3.3.0 :111 > books = Book.preload(:author).limit(4)
        Book Load (1.1ms)  SELECT "books".* FROM "books" /* loading for pp */ LIMIT $1  [["LIMIT", 4]]
        Author Load (0.8ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1  [["id", 10]]
       => 
      [#<Book:0x000000012e7fdfd0
      3.3.0 :116 > books.each do |book|
        3.3.0 :117 >   puts book.author.author_name
        3.3.0 :118 > end
        J.K. Rowling
        J.K. Rowling
        J.K. Rowling
        J.K. Rowling


  4) eager_load -> With eager_load, Active Record loads all specified associations using a LEFT OUTER JOIN.
      Example:
        3.3.0 :119 > books = Book.eager_load(:author).limit(4)
        3.3.0 :121 > books.each do |book|
        3.3.0 :122 >   puts book.author.author_name
        3.3.0 :123 > end
            SQL (1.3ms)  SELECT "books"."id" AS t0_r0, "books"."isbn" AS t0_r1, "books"."title" AS t0_r2, "books"."quantity" AS t0_r3, "books"."created_at" 
            AS t0_r4, "books"."updated_at" AS t0_r5, "books"."available_quantity" AS t0_r6, "books"."author_id" AS t0_r7, "books"."genre_id" AS t0_r8,
             "authors"."id" AS t1_r0, "authors"."author_name" AS t1_r1, "authors"."nationality" AS t1_r2, "authors"."created_at" AS t1_r3, "authors"."updated_at" 
             AS t1_r4, "authors"."books_count" AS t1_r5, "authors"."lock_version" AS t1_r6 FROM "books" LEFT OUTER JOIN "authors" ON
              "authors"."id" = "books"."author_id" LIMIT $1  [["LIMIT", 4]]
          J.K. Rowling
          J.K. Rowling
          J.K. Rowling
          J.K. Rowling
 

  5) strict_loading ->
    Eager loading can prevent N + 1 queries but you might still be lazy loading some associations. 
    To make sure no associations are lazy loaded you can enable strict_loading.
    By enabling strict loading mode on a relation, an ActiveRecord::StrictLoadingViolationError will be raised if the record tries to lazily load any association:
        Example:
          3.3.0 :124 > genre = Genre.strict_loading.first
          Genre Load (1.0ms)  SELECT "genres".* FROM "genres" ORDER BY "genres"."id" ASC LIMIT $1  [["LIMIT", 1]]
           => 
            #<Genre:0x000000012e7df3c8
          3.3.0 :128 > genre.books.first
          (irb):128:in `<main>`: `Genre` is marked for strict_loading. The Book association named `:books` cannot be lazily loaded. (ActiveRecord::StrictLoadingViolationError) 
                                       
                    
  6) strict_loading! ->
    We can also enable strict loading on the record itself by calling strict_loading!:
      Example:
      3.3.0 :131 > genre = Genre.first
        Genre Load (0.8ms)  SELECT "genres".* FROM "genres" ORDER BY "genres"."id" ASC LIMIT $1  [["LIMIT", 1]]
       => 
      #<Genre:0x000000012e7d3d48
      ... 
      3.3.0 :132 > genre.strict_loading!
       => true 
      3.3.0 :133 > genre.books.first
      (irb):133:in `<main>`: `Genre` is marked for strict_loading. The Book association named `:books` cannot be lazily loaded. (ActiveRecord::StrictLoadingViolationError)
    
    strict_loading! also takes a :mode argument. Setting it to :n_plus_one_only will only raise an error if an association that will lead to an N + 1 query is lazily loaded:
      Example:
      3.3.0 :131 > genre = Genre.first
      Genre Load (0.8ms)  SELECT "genres".* FROM "genres" ORDER BY "genres"."id" ASC LIMIT $1  [["LIMIT", 1]]
       => 
      #<Genre:0x000000012e7d3d48
      ... 
      3.3.0 :134 > genre.strict_loading!(mode: :n_plus_one_only)
      3.3.0 :135 > 
       => true 
      3.3.0 :136 > genre.books.first
        Book Load (1.0ms)  SELECT "books".* FROM "books" WHERE "books"."genre_id" = $1  [["genre_id", 1]]
       => 
      #<Book:0x000000012e7f8d5




====> SCOPES
Scoping allows you to specify commonly-used queries which can be referenced as method calls on the association objects or models. 
With these scopes, you can use every method previously covered such as where, joins and includes. 
All scope bodies should return an ActiveRecord::Relation or nil to allow for further methods (such as other scopes) to be called on it.

Example:
class Item < ApplicationRecord
  scope :out_of_stock, -> { where(stock: 0) }
end

3.3.0 :146 > Item.out_of_stock
  Item Load (0.4ms)  SELECT "items".* FROM "items" WHERE "items"."stock" = $1 /* loading for pp */ LIMIT $2  [["stock", 0], ["LIMIT", 11]]
 => 
[#<Item:0x000000012e91d4d8
  id: 7,
  name: "High-End Item",
  price: 0.14e3,
  stock: 0,
  available: true,
  created_at: Sat, 27 Jul 2024 11:22:40.614121000 UTC +00:00,
  updated_at: Sat, 27 Jul 2024 11:22:40.614121000 UTC +00:00>,
 #<Item:0x000000012e798ae0
  id: 9,
  name: "Standard Item",
  price: 0.9e2,
  stock: 0,
  available: true,
  created_at: Sat, 27 Jul 2024 11:22:48.996696000 UTC +00:00,
  updated_at: Sat, 27 Jul 2024 11:22:48.996696000 UTC +00:00>] 


    a) Passing in Arguments -> 
          Example:
          class Item < ApplicationRecord
            scope :costs_more_than, ->(amount) { where("price > ?", amount) }
          end

          3.3.0 :150 > Item.costs_more_than(50)
          Item Load (1.8ms)  SELECT "items".* FROM "items" WHERE (price > 50) /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
         => 
        [#<Item:0x000000012ea98790
          id: 1,
          name: "Luxury Item",
          price: 0.11e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:15:13.510127000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:15:13.510127000 UTC +00:00>,
         #<Item:0x000000012e7ba640
          id: 3,
          name: "Expensive Item",
          price: 0.11e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:17:33.303071000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:17:33.303071000 UTC +00:00>,
         #<Item:0x000000012e7ba500
          id: 4,
          name: "[FILTERED] Luxury Item",
          price: 0.12e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:20:21.395820000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:20:21.395820000 UTC +00:00>,


    b) Using Conditionals -> 
          Example:
          class Item < ApplicationRecord
            scope :in_stock_above, ->(quantity) { where("stock > ?", quantity) if quantity.present? }
          end

          3.3.0 :152 > Item.in_stock_above(10)
          3.3.0 :153 > 
            Item Load (2.9ms)  SELECT "items".* FROM "items" WHERE (stock > 10) /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
           => 
          [#<Item:0x000000012e459cf8
            id: 6,
            name: "Regular Item",
            price: 0.7e2,
            stock: 15,
            available: true,
            created_at: Sat, 27 Jul 2024 11:20:30.581363000 UTC +00:00,
            updated_at: Sat, 27 Jul 2024 11:20:30.581363000 UTC +00:00>,
           #<Item:0x000000012e7d8488
            id: 10,
            name: "Item 1",
            price: 0.1999e2,
            stock: 100,
            available: true,
            created_at: Mon, 29 Jul 2024 11:07:50.601898000 UTC +00:00,
            updated_at: Mon, 29 Jul 2024 11:07:50.601898000 UTC +00:00>,
           #<Item:0x000000012e7d8348
            id: 11,
            name: "Item 2",
            price: 0.2999e2,
            stock: 200,
            available: false,
            created_at: Mon, 29 Jul 2024 11:07:50.623788000 UTC +00:00,
            updated_at: Mon, 29 Jul 2024 11:07:50.623788000 UTC +00:00>,
           #<Item:0x000000012e7d8208
            id: 12,
            name: "Item 3",
            price: 0.3999e2,
            stock: 150,
            available: true,
            created_at: Mon, 29 Jul 2024 11:07:50.624944000 UTC +00:00,
            updated_at: Mon, 29 Jul 2024 11:07:50.624944000 UTC +00:00>] 
          

    c) Applying a Default Scope -> 
          Example:
          class Item < ApplicationRecord
            default_scope { where(available: true).where("stock > ?", 0) }
          end

          3.3.0 :165 > Item.all
            Item Load (0.5ms)  SELECT "items".* FROM "items" WHERE "items"."available" = $1 AND (stock > 10) /* loading for pp */ LIMIT $2  [["available", true], ["LIMIT", 11]]
          3.3.0 :166 > Item.unscoped.all
          3.3.0 :167 > 
            Item Load (0.6ms)  SELECT "items".* FROM "items" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]


    d) Merging of Scopes -> 
        Example:
        3.3.0 :171 > Item.available.in_stock.expensive(50)
          Item Load (0.7ms)  SELECT "items".* FROM "items" WHERE "items"."available" = $1 AND (stock > 0) AND (price > 50) /* loading for pp */ LIMIT $2  [["available", true], ["LIMIT", 11]]
         => 
        [#<Item:0x000000012eabc938
          id: 1,
          name: "Luxury Item",
          price: 0.11e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:15:13.510127000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:15:13.510127000 UTC +00:00>,
         #<Item:0x000000012e7b4c40
          id: 3,
          name: "Expensive Item",
          price: 0.11e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:17:33.303071000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:17:33.303071000 UTC +00:00>,
         #<Item:0x000000012e7b4b00
          id: 4,
          name: "[FILTERED] Luxury Item",
          price: 0.12e3,
          stock: 5,
          available: true,
          created_at: Sat, 27 Jul 2024 11:20:21.395820000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:20:21.395820000 UTC +00:00>,
         #<Item:0x000000012e7b49c0
          id: 6,
          name: "Regular Item",
          price: 0.7e2,
          stock: 15,
          available: true,
          created_at: Sat, 27 Jul 2024 11:20:30.581363000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:20:30.581363000 UTC +00:00>,
         #<Item:0x000000012e7b4880
          id: 8,
          name: "High-End Item in Stock",
          price: 0.12e3,
          stock: 10,
          available: true,
          created_at: Sat, 27 Jul 2024 11:22:44.942192000 UTC +00:00,
          updated_at: Sat, 27 Jul 2024 11:22:44.942192000 UTC +00:00>] 


    e) Removing All Scoping -> 
        Example:
          3.3.0 :172 > Item.unscoped.load
          Item Load (1.2ms)  SELECT "items".* FROM "items"




====> DYNAMIC FINDERS
For every field (also known as an attribute) you define in your table, Active Record provides a finder method. 
If you have a field called first_name on your Customer model for example, you get the instance method find_by_first_name for free from Active Record. 
If you also have a locked field on the Customer model, you also get find_by_locked method.

Example:
* 3.3.0 :173 > Item.find_by_stock(100)
    Item Load (0.6ms)  SELECT "items".* FROM "items" WHERE "items"."stock" = $1 LIMIT $2  [["stock", 100], ["LIMIT", 1]]
   => 
  #<Item:0x000000012e7f4b10
   id: 10,
   name: "Item 1",
   price: 0.1999e2,
   stock: 100,
   available: true,
   created_at: Mon, 29 Jul 2024 11:07:50.601898000 UTC +00:00,
   updated_at: Mon, 29 Jul 2024 11:07:50.601898000 UTC +00:00> 

* 3.3.0 :174 > Item.find_by_stock_and_price(100,0.9e2)
    Item Load (0.8ms)  SELECT "items".* FROM "items" WHERE "items"."stock" = $1 AND "items"."price" = $2 LIMIT $3  [["stock", 100], ["price", "90.0"], ["LIMIT", 1]]
   => nil 




====> ENUMS
An enum lets you define an Array of values for an attribute and refer to them by name. 
The actual value stored in the database is an integer that has been mapped to one of the values.

Declaring an enum will:
* Create scopes that can be used to find all objects that have or do not have one of the enum values
* Create an instance method that can be used to determine if an object has a particular value for the enum
* Create an instance method that can be used to change the enum value of an object for all possible values of an enum.

Example:
class Item < ApplicationRecord
  enum availability: { in_stock: 0, out_of_stock: 1, discontinued: 2 }
end

3.3.0 :184 > Item.in_stock
3.3.0 :185 > 
  Item Load (0.6ms)  SELECT "items".* FROM "items" WHERE "items"."availability" = $1 /* loading for pp */ LIMIT $2  [["availability", 0], ["LIMIT", 11]]
 => 
[#<Item:0x000000012e7b3d40
  id: 15,
  name: "Widget A",
  price: nil,
  stock: nil,
  available: nil,
  created_at: Mon, 29 Jul 2024 11:40:40.326737000 UTC +00:00,
  updated_at: Mon, 29 Jul 2024 11:40:40.326737000 UTC +00:00,
  availability: "in_stock">] 
3.3.0 :186 > Item.out_of_stock
3.3.0 :187 > 
  Item Load (0.7ms)  SELECT "items".* FROM "items" WHERE "items"."availability" = $1 /* loading for pp */ LIMIT $2  [["availability", 1], ["LIMIT", 11]]
 => 
[#<Item:0x000000012e79e120
  id: 16,
  name: "Widget B",
  price: nil,
  stock: nil,
  available: nil,
  created_at: Mon, 29 Jul 2024 11:40:40.331293000 UTC +00:00,
  updated_at: Mon, 29 Jul 2024 11:40:40.331293000 UTC +00:00,
  availability: "out_of_stock">] 




====> UNDERSTANDING METHOD CHAINING
The Active Record pattern implements Method Chaining, which allow us to use multiple Active Record methods together in a simple and straightforward way.

  1) Retrieving Filtered Data from Multiple Tables
      Example:
      3.3.0 :192 > Book.select('authors.author_name, books.title').joins(:author).where('authors.created_at > ?', 2.days.ago)
        Book Load (1.6ms)  SELECT authors.author_name, books.title FROM "books" INNER JOIN "authors" ON "authors"."id" = "books"."author_id"
         WHERE (authors.created_at > '2024-07-27 11:47:28.212868') /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
       => [#<Book:0x000000012d2f8e50 id: nil, title: "Sample Book">, #<Book:0x000000012efff148 id: nil, title: "Sample Book">] 

  2) Retrieving Specific Data from Multiple Tables
      Example:
      3.3.0 :197 > Book
      3.3.0 :198 >   .select('authors.author_name, books.title')
      3.3.0 :199 >   .joins(:author)
      3.3.0 :200 > .find_by(title: "Algorithms, second edition")
        Book Load (2.1ms)  SELECT authors.author_name, books.title FROM "books" INNER JOIN "authors" ON "authors"."id" = "books"."author_id" WHERE "books"."title" = $1 LIMIT $2  [["title", "Algorithms, second edition"], ["LIMIT", 1]]
       => #<Book:0x000000012f038358 id: nil, title: "Algorithms, second edition"> 



=====> FIND OR BUILD A NEW OBJECT

  1) find_or_create_by -> The find_or_create_by method checks whether a record with the specified attributes exists. If it doesnt, then create is called.
      Example:
      3.3.0 :202 > Item.find_or_create_by(name: "Book")
        Item Load (0.5ms)  SELECT "items".* FROM "items" WHERE "items"."name" = $1 LIMIT $2  [["name", "Book"], ["LIMIT", 1]]
        TRANSACTION (0.2ms)  BEGIN
        Item Create (1.3ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at", "availability") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["name", "Book"], ["price", nil], ["stock", nil], ["available", nil], ["created_at", "2024-07-29 11:51:43.930173"], ["updated_at", "2024-07-29 11:51:43.930173"], ["availability", 0]]
        TRANSACTION (1.4ms)  COMMIT
       => 
      #<Item:0x000000012f030f18
       id: 17,
       name: "Book",
       price: nil,
       stock: nil,
       available: nil,
       created_at: Mon, 29 Jul 2024 11:51:43.930173000 UTC +00:00,
       updated_at: Mon, 29 Jul 2024 11:51:43.930173000 UTC +00:00,
       availability: "in_stock"> 

  2) find_or_create_by! -> We can also use find_or_create_by! to raise an exception if the new record is invalid.

  3) find_or_initialize_by -> The find_or_initialize_by method will work just like find_or_create_by but it will call new instead of create. 
                              This means that a new model instance will be created in memory but wont be saved to the database.
        Example:
        3.3.0 :205 > Item.find_or_initialize_by(name: "Book")
          Item Load (0.4ms)  SELECT "items".* FROM "items" WHERE "items"."name" = $1 LIMIT $2  [["name", "Book"], ["LIMIT", 1]]
          => 
        #<Item:0x000000012f030f18
         id: 17,
         name: "Book",
         price: nil,
         stock: nil,
         available: nil,
         created_at: Mon, 29 Jul 2024 11:51:43.930173000 UTC +00:00,
         updated_at: Mon, 29 Jul 2024 11:51:43.930173000 UTC +00:00,
         availability: "in_stock">





=====> FINDING BY SQL
If we like to use our own SQL to find records in a table you can use find_by_sql. 
The find_by_sql method will return an array of objects even if the underlying query returns just a single record. 

Example:
3.3.0 :212 > Item.find_by_sql("SELECT * FROM items WHERE price > 100 ORDER BY created_at DESC")
3.3.0 :213 > 
  Item Load (0.8ms)  SELECT * FROM items WHERE price > 100 ORDER BY created_at DESC
 => 
[#<Item:0x000000012e7d8d48
  id: 20,
  name: "Item C",
  price: 0.2e3,
  stock: 10,
  available: false,
  created_at: Mon, 29 Jul 2024 12:01:26.499490000 UTC +00:00,
  updated_at: Mon, 29 Jul 2024 12:01:26.499490000 UTC +00:00,
  availability: "in_stock">,
 #<Item:0x000000012e7d8c08
  id: 18,
  name: "Item A",
  price: 0.15e3,
  stock: 20,
  available: true,
  created_at: Mon, 29 Jul 2024 12:01:26.492495000 UTC +00:00,
  updated_at: Mon, 29 Jul 2024 12:01:26.492495000 UTC +00:00,
  availability: "in_stock">]

    1) Select_all ->
    * Item.connection.select_all: Executes a raw SQL query on the items table.
    * "SELECT name, price, stock, available FROM items WHERE available = true": The SQL query string, selecting columns and applying a condition.
    * .to_a: Converts the result to an array of hashes. Each hash represents a row with column names as keys and their corresponding values.  

        Example:
        3.3.0 :214 > results = Item.connection.select_all("SELECT name, price, stock, available FROM items WHERE available = true").to_a
          (1.8ms)  SELECT name, price, stock, available FROM items WHERE available = true
        => 
       [{"name"=>"Item A", "price"=>0.15e3, "stock"=>20, "available"=>true},
       ... 
       3.3.0 :215 > results
        => 
       [{"name"=>"Item A", "price"=>0.15e3, "stock"=>20, "available"=>true},
        {"name"=>"Item B", "price"=>0.75e2, "stock"=>50, "available"=>true},
        {"name"=>"Item D", "price"=>0.5e2, "stock"=>100, "available"=>true}] 

    
    2) pluck -> pluck is a powerful and efficient method for retrieving specific columns from your database. 
                It directly queries the database and returns an array of values or arrays of values for the 
                specified columns, bypassing the need to instantiate ActiveRecord objects.
          Example:
          3.3.0 :216 > item_names = Item.pluck(:name)
          3.3.0 :217 > 
            Item Pluck (1.7ms)  SELECT "items"."name" FROM "items"
           => ["Widget A", "Widget B", "Book", "Item A", "Item B", "Item C", "Item D"] 
          3.3.0 :218 > available_items = Item.where(available: true).pluck(:name, :price)
            Item Pluck (0.3ms)  SELECT "items"."name", "items"."price" FROM "items" WHERE "items"."available" = $1  [["available", true]]
           => [["Item A", 0.15e3], ["Item B", 0.75e2], ["Item D", 0.5e2]] 
          3.3.0 :219 > availability_statuses = Item.distinct.pluck(:available)
            Item Pluck (2.1ms)  SELECT DISTINCT "items"."available" FROM "items"
           => [false, nil, true] 

      
    3) pick -> pick can be used to pick the value(s) from the named column(s) in the current relation.
               It accepts a list of column names as an argument and returns the first row of the specified column values with corresponding data type.
          Example:
            3.3.0 :221 > Item.where(id: 15).pick(:id)
            Item Pluck (1.4ms)  SELECT "items"."id" FROM "items" WHERE "items"."id" = $1 LIMIT $2  [["id", 15], ["LIMIT", 1]]
           => 15 


    4) ids -> ids can be used to pluck all the IDs for the relation using the tables primary key.
        Example:
          3.3.0 :222 > Item.ids
          Item Ids (1.7ms)  SELECT "items"."id" FROM "items"
         => [15, 16, 17, 18, 19, 20, 21] 




====> EXISTANCE OF OBJECTS
If we simply want to check for the existence of the object theres a method called exists?. 
This method will query the database using the same query as find, but instead of returning an object or collection of objects it will return either true or false.

Example:
3.3.0 :223 > Item.exists?(1)
  Item Exists? (2.2ms)  SELECT 1 AS one FROM "items" WHERE "items"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => false 

3.3.0 :224 > Item.exists?(15)
  Item Exists? (1.0ms)  SELECT 1 AS one FROM "items" WHERE "items"."id" = $1 LIMIT $2  [["id", 15], ["LIMIT", 1]]
 => true 

3.3.0 :226 > Item.where(name:"Item D").exists?
  Item Exists? (2.0ms)  SELECT 1 AS one FROM "items" WHERE "items"."name" = $1 LIMIT $2  [["name", "Item D"], ["LIMIT", 1]]
 => true 




====> CALCULATIONS
This section uses count as an example method in this preamble, but the options described apply to all sub-sections.

  1) Count
      Example:
        3.3.0 :227 > Item.count(:name)
        Item Count (1.6ms)  SELECT COUNT("items"."name") FROM "items"
       => 7 
      
  2) Average
      Example:
        3.3.0 :229 > Item.average("price")
        Item Average (2.1ms)  SELECT AVG("items"."price") FROM "items"
       => 0.11875e3 

  3) Minimum
      Example:
        3.3.0 :230 > Item.minimum("stock")
        Item Minimum (3.8ms)  SELECT MIN("items"."stock") FROM "items"
       => 10 

  4) Maximum
      Example:
        3.3.0 :230 > Item.minimum("stock")
        Item Minimum (3.8ms)  SELECT MIN("items"."stock") FROM "items"
       => 10 

  5) Sum
      Example:
        3.3.0 :232 > Item.sum("stock")
        Item Sum (1.4ms)  SELECT SUM("items"."stock") FROM "items"
       => 180 




====> RUNNING EXPLAIN
You can run explain on a relation. EXPLAIN output varies for each database.
EXPLAIN command and analyze the query performance in Rails, you can use the following methods. 
This command helps you understand how SQL queries are executed and can be useful for optimizing performance.

Example:
3.3.0 :234 > Book.select("author_id").group("author_id").explain
  Book Load (2.4ms)  SELECT "books"."author_id" FROM "books" GROUP BY "books"."author_id"
 => 
EXPLAIN SELECT "books"."author_id" FROM "books" GROUP BY "books"."author_id"
                          QUERY PLAN
--------------------------------------------------------------
 HashAggregate  (cost=17.25..19.25 rows=200 width=8)
   Group Key: author_id
   ->  Seq Scan on books  (cost=0.00..15.80 rows=580 width=8)
(3 rows)


3.3.0 :238 > Author.joins(:books).where(books: { author: author }).explain(:analyze)
  Author Load (0.9ms)  SELECT "authors".* FROM "authors" INNER JOIN "books" ON "books"."author_id" = "authors"."id" WHERE "books"."author_id" = $1  [["author_id", 15]]
 => 
EXPLAIN (ANALYZE) SELECT "authors".* FROM "authors" INNER JOIN "books" ON "books"."author_id" = "authors"."id" WHERE "books"."author_id" = $1 [["author_id", 15]]
                                                              QUERY PLAN
---------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=4.32..19.48 rows=3 width=96) (actual time=0.046..0.047 rows=1 loops=1)
   ->  Index Scan using authors_pkey on authors  (cost=0.15..8.17 rows=1 width=96) (actual time=0.038..0.039 rows=1 loops=1)
         Index Cond: (id = '15'::bigint)
   ->  Bitmap Heap Scan on books  (cost=4.17..11.28 rows=3 width=8) (actual time=0.004..0.004 rows=1 loops=1)
         Recheck Cond: (author_id = '15'::bigint)
         Heap Blocks: exact=1
         ->  Bitmap Index Scan on index_books_on_author_id  (cost=0.00..4.17 rows=3 width=0) (actual time=0.002..0.002 rows=1 loops=1)
               Index Cond: (author_id = '15'::bigint)
 Planning Time: 0.106 ms
 Execution Time: 0.107 ms
(10 rows)


3.3.0 :235 > Book.select("author_id").group("author_id").explain(:analyze, :verbose)
  Book Load (0.6ms)  SELECT "books"."author_id" FROM "books" GROUP BY "books"."author_id"
 => 
EXPLAIN (ANALYZE, VERBOSE) SELECT "books"."author_id" FROM "books" GROUP BY "books"."author_id"
                                                   QUERY PLAN
----------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=17.25..19.25 rows=200 width=8) (actual time=0.030..0.033 rows=5 loops=1)
   Output: author_id
   Group Key: books.author_id
   Batches: 1  Memory Usage: 40kB
   ->  Seq Scan on public.books  (cost=0.00..15.80 rows=580 width=8) (actual time=0.012..0.014 rows=10 loops=1)
         Output: id, isbn, title, quantity, created_at, updated_at, available_quantity, author_id, genre_id
 Planning Time: 0.091 ms
 Execution Time: 0.071 ms
(8 rows)
