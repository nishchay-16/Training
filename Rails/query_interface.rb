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
  (irb):664:in `<main>': Book is marked as readonly (ActiveRecord::ReadOnlyRecord)