                              ACTIVE RECORD CALLBACKS

Callbacks are methods that get called at certain moments of an objects life cycle. 
With callbacks it is possible to write code that will run whenever an Active Record object is created, saved, updated, deleted, validated, or loaded from the database.


===> Creating an Object 

1) before_validation -> It defines a callback that will get called right before validation.
      Example:
      => #<Article:0x000000011dcaef40 id: nil, title: "test title", content: nil, created_at: nil, updated_at: nil> 
      3.3.0 :152 > article.valid?
       => false 
      3.3.0 :153 > article.title
      3.3.0 :154 > 
       => "Test Title"                   
           
2) after_validation -> It defines a callback that will get called right after validation.
      Example: 
      3.3.0 :156 > article = Article.new(title: "test title")
      => #<Article:0x00000001208f2570 id: nil, title: "test title", content: nil, created_at: nil, updated_at: nil> 
      3.3.0 :157 > article.valid?
      3.3.0 :158 > 
      => false 
      3.3.0 :159 > article.title
      => "Test Title" 
      3.3.0 :160 > article.content
      => "Default content" 

3) before_save -> Registers a callback to be called before a record is saved.
      Example:
      3.3.0 :176 > article = Article.new(content: "This is some content.")
      => #<Article:0x0000000120e92a48 id: nil, title: nil, content: "This is some content.", created_at: nil, updated_at: nil> 
      3.3.0 :177 > article.save
       TRANSACTION (0.3ms)  BEGIN
       Article Create (6.2ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  
       [["title", "Untitled"], ["content", "This is some content."], ["created_at", "2024-07-27 07:59:23.935535"], ["updated_at", "2024-07-27 07:59:23.935535"]]
       TRANSACTION (0.7ms)  COMMIT
      => true 
      3.3.0 :178 > article.title
      => "Untitled" 

4) around_save -> Registers a callback to be called around the save of a record. 
      Example:
      3.3.0 :180 > article = Article.new(title: "test title", content: "This is some content.")
      => #<Article:0x000000011fadf7d0 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil> 
      3.3.0 :181 > article.save
      Around Save: Before Save
       TRANSACTION (0.4ms)  BEGIN
       Article Create (2.8ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  
       [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:07:04.150654"], ["updated_at", "2024-07-27 08:07:04.150654"]]
      Around Save: After Save
       TRANSACTION (1.3ms)  COMMIT
      => true 

5) after_save -> Registers a callback to be called after a record is saved.
      Example:
      => #<Article:0x00000001216d5c00 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil> 
      3.3.0 :185 > article.save
      3.3.0 :186 > 
      Around Save: Before Save
        TRANSACTION (0.2ms)  BEGIN
        Article Create (2.1ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  
        [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:10:04.125095"], ["updated_at", "2024-07-27 08:10:04.125095"]]
      Around Save: After Save
      After Save: Updated search index
        TRANSACTION (1.4ms)  COMMIT
       => true     

6) before_create -> Registers a callback to be called before a record is created.
      Example:
      3.3.0 :189 > article = Article.new(title: "test title", content: "This is some content.")
      3.3.0 :190 > 
       => #<Article:0x0000000120bd7128 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil, published_at: nil> 
      3.3.0 :191 > article.save
      3.3.0 :192 > 
      Around Save: Before Save
        TRANSACTION (0.3ms)  BEGIN
        Article Create (2.0ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at", "published_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  
        [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:18:55.752351"], ["updated_at", "2024-07-27 08:18:55.752351"], 
        ["published_at", "2024-07-27 08:18:55.752567"]]
      Around Save: After Save
      After Save: Updated search index
        TRANSACTION (1.6ms)  COMMIT
       => true 
      3.3.0 :193 > article.reload
        Article Load (0.5ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 4], ["LIMIT", 1]]
       => 
      #<Article:0x0000000120bd7128
       id: 4,
       title: "Test Title",
       content: "This is some content.",
       created_at: Sat, 27 Jul 2024 08:18:55.752351000 UTC +00:00,
       updated_at: Sat, 27 Jul 2024 08:18:55.752351000 UTC +00:00,
       published_at: Sat, 27 Jul 2024 08:18:55.752567000 UTC +00:00> 
      3.3.0 :194 > article.published_at
       => Sat, 27 Jul 2024 08:18:55.752567000 UTC +00:00 

7) around_create -> Registers a callback to be called around the creation of a record.
      Example:
      3.3.0 :198 > article = Article.new(title: "test title", content: "This is some content.")
      3.3.0 :199 > 
       => #<Article:0x0000000120e37698 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil, published_at: nil> 
      3.3.0 :200 > 
      3.3.0 :201 > article.save
      3.3.0 :202 > 
      Around Save: Before Save
      Around Create: Before Create
        TRANSACTION (0.3ms)  BEGIN
        Article Create (3.1ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at", "published_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  
        [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:21:39.070703"], ["updated_at", "2024-07-27 08:21:39.070703"], 
        ["published_at", "2024-07-27 08:21:39.071149"]]
      Around Create: After Create
      Around Save: After Save
      After Save: Updated search index
        TRANSACTION (0.9ms)  COMMIT
       => true 
      
8) after_create -> Registers a callback to be called after a record is created.
      Example:
      => #<Article:0x0000000121697b80 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil, published_at: nil> 
      3.3.0 :206 > article.save
      3.3.0 :207 > 
        TRANSACTION (0.4ms)  BEGIN
        Article Create (3.2ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at", "published_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  
        [["title", "test title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:32:01.190514"], ["updated_at", "2024-07-27 08:32:01.190514"], 
        ["published_at", nil]]
      After Create: Notification sent to the author
        TRANSACTION (1.1ms)  COMMIT
       => true 
      
9) after_commit -> The after_commit callback runs after a record has been saved and committed to the database, 
                  making it a good place to perform actions that should only occur if the transaction is successful.
      Example:
      3.3.0 :209 > article = Article.new(title: "test title", content: "This is some content.")
      => #<Article:0x0000000120c582a0 id: nil, title: "test title", content: "This is some content.", created_at: nil, updated_at: nil, published_at: nil> 
      3.3.0 :210 > article.save
       TRANSACTION (0.4ms)  BEGIN
       Article Create (2.7ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at", "published_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["title", "test title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:35:56.426429"], ["updated_at", "2024-07-27 08:35:56.426429"], ["published_at", nil]]
       TRANSACTION (1.7ms)  COMMIT
      After Commit: Changes have been committed
      => true 
      3.3.0 :211 > article.update(content: "Updated content")
      3.3.0 :212 > 
       TRANSACTION (0.3ms)  BEGIN
       Article Update (4.8ms)  UPDATE "articles" SET "content" = $1, "updated_at" = $2 WHERE "articles"."id" = $3  [["content", "Updated content"], ["updated_at", "2024-07-27 08:36:09.163225"], ["id", 7]]
       TRANSACTION (0.7ms)  COMMIT
      After Commit: Changes have been committed
      => true 

10) after_rollback -> the after_rollback callback will be triggered, you need to simulate a situation where an error causes a transaction to fail. 
                      This typically involves creating a model instance with invalid data that triggers a rollback.




===>  Updating an Object

1) before_update -> Registers a callback to be called before a record is updated.
      Example:
      3.3.0 :257 > article = Article.find_by(id: 1)
      Article Load (0.7ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
     => 
      #<Article:0x000000012169df30
      ... 
      3.3.0 :258 > article.title = "Updated Title"
       => "Updated Title" 
      3.3.0 :259 > article.save
        Before Update: Log before update
        TRANSACTION (0.4ms)  BEGIN
       Article Update (2.8ms)  UPDATE "articles" SET "title" = $1, "updated_at" = $2 WHERE "articles"."id" = $3  [["title", "Updated Title"], ["updated_at", "2024-07-27 09:09:57.498682"], ["id", 1]]
       TRANSACTION (1.6ms)  COMMIT
      => true 

2) around_update -> Registers a callback to be called around the update of a record.
      Example:
      3.3.0 :261 > article = Article.find_by(id: 1)
      Article Load (0.7ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
     => 
      #<Article:0x0000000121370060
      ... 
      3.3.0 :262 > article.title = "Updated Title"
       => "Updated Title" 
      3.3.0 :263 > article.save
      Around Update: Before update
      Around Update: After update
      => true

3) after_update -> Registers a callback to be called after a record is updated.
      Example:
      3.3.0 :265 > article = Article.find_by(id: 1)
      Article Load (0.5ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
     => 
      #<Article:0x0000000120bdf5a8
      ... 
      3.3.0 :266 > article.title = "Rules"
      => "Rules" 
      3.3.0 :267 > article.save
        TRANSACTION (0.3ms)  BEGIN
        Article Update (1.2ms)  UPDATE "articles" SET "title" = $1, "updated_at" = $2 WHERE "articles"."id" = $3  [["title", "Rules"], ["updated_at", "2024-07-27 09:14:33.392909"], ["id", 1]]
      After Update: Log after update
        TRANSACTION (0.4ms)  COMMIT
      => true 



===>  Destroying an Object

1) before_destroy -> Registers a callback to be called before a record is destroyed.
      Example:
      3.3.0 :276 > article = Article.find_by(id: 7)
      Article Load (0.6ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 7], ["LIMIT", 1]]
     => 
      #<Article:0x0000000120bd69d0
      ... 
      3.3.0 :277 > article.destroy
      Before Destroy: Destroyed the article no 7 at 2024-07-27 09:26:25 UTC
        TRANSACTION (0.3ms)  BEGIN
        Article Destroy (1.3ms)  DELETE FROM "articles" WHERE "articles"."id" = $1  [["id", 7]]
        TRANSACTION (1.4ms)  COMMIT
      => 
      #<Article:0x0000000120bd69d0
       id: 7,
       title: "test title",
       content: "Updated content",
       created_at: Sat, 27 Jul 2024 08:35:56.426429000 UTC +00:00,
       updated_at: Sat, 27 Jul 2024 08:36:09.163225000 UTC +00:00,
       published_at: nil> 

2) after_destroy -> Registers a callback to be called after a record is destroyed.
      Example:
      3.3.0 :279 > article = Article.find_by(id: 6)
      Article Load (0.4ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 6], ["LIMIT", 1]]
       => 
      #<Article:0x0000000120c17b38
      ... 
      3.3.0 :280 > article.destroy
      Before Destroy: Destroyed the article no 6 at 2024-07-27 09:28:55 UTC
        TRANSACTION (0.2ms)  BEGIN
        Article Destroy (0.9ms)  DELETE FROM "articles" WHERE "articles"."id" = $1  [["id", 6]]
      After Destroy: Successfully destroyed the article test title
        TRANSACTION (1.0ms)  COMMIT
       => 
      #<Article:0x0000000120c17b38
       id: 6,
       title: "test title",
       content: "This is some content.",
       created_at: Sat, 27 Jul 2024 08:32:01.190514000 UTC +00:00,
       updated_at: Sat, 27 Jul 2024 08:32:01.190514000 UTC +00:00,
       published_at: nil> 

3) around_destroy -> Registers a callback to be called around a record is destroyed.
      Example:
      3.3.0 :282 > article = Article.find_by(id: 5)
      Article Load (0.4ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 5], ["LIMIT", 1]]
     => 
      #<Article:0x0000000121696b68
      ... 
      3.3.0 :283 > article.destroy
      Before Destroy: Destroyed the article no 5 at 2024-07-27 09:31:54 UTC
      Around Destroy: Started Destroying the article no 5
        TRANSACTION (0.4ms)  BEGIN
        Article Destroy (1.4ms)  DELETE FROM "articles" WHERE "articles"."id" = $1  [["id", 5]]
      Around Destroy: The article no 5 has been destroyed
      After Destroy: Successfully destroyed the article Test Title
        TRANSACTION (2.7ms)  COMMIT
       => 
      #<Article:0x0000000121696b68
       id: 5,
       title: "Test Title",
       content: "This is some content.",
       created_at: Sat, 27 Jul 2024 08:21:39.070703000 UTC +00:00,
       updated_at: Sat, 27 Jul 2024 08:21:39.070703000 UTC +00:00,
       published_at: Sat, 27 Jul 2024 08:21:39.071149000 UTC +00:00> 

  IMPORTANT: 
    * Callbacks are executed in the order they were registered.
    * before_destroy callbacks should be placed before dependent: :destroy associations (or use the prepend: true option), 
      to ensure they execute before the records are deleted by dependent: :destroy.




===> after_initialize and after_find callbacks

Whenever an Active Record object is instantiated the after_initialize callback will be called, either by directly using new or when a record is loaded from the database. 
It can be useful to avoid the need to directly override your Active Record initialize method.
When loading a record from the database the after_find callback will be called. after_find is called before after_initialize if both are defined.

Example:
3.3.0 :293 > Article.new
A new article is initialized!
 => #<Article:0x0000000120e98380 id: nil, title: nil, content: nil, created_at: nil, updated_at: nil, published_at: nil> 
3.3.0 :294 > article = Article.find_by(id: 2)
  Article Load (0.5ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
You have found an article!
A new article is initialized!
 => 
#<Article:0x00000001216f3ac0
... 

  Note:- The after_initialize and after_find callbacks have no before_* counterparts.




===> after_touch Callback

The after_touch callback is triggered whenever an Active Record object is touched. 
This is typically done using the touch method, which updates the updated_at timestamp (or a custom timestamp column if specified) without changing any other attributes.
The after_touch callback is executed after the record is touched using the touch method.

class Article < ApplicationRecord
  after_touch do |article|
    puts "You have touched article #{article.title}"
  end
end

3.3.0 :296 > article = Article.find_by(id: 2)
  Article Load (0.4ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
You have found an article!
A new article is initialized!
 => 
#<Article:0x000000011ec13120
... 
3.3.0 :297 > article.touch
  TRANSACTION (0.4ms)  BEGIN
  Article Update (1.5ms)  UPDATE "articles" SET "updated_at" = $1 WHERE "articles"."id" = $2  [["updated_at", "2024-07-27 09:54:46.557943"], ["id", 2]]
You have touched article Test Title
  TRANSACTION (2.4ms)  COMMIT
 => true 


Example 2:
class Book < ApplicationRecord
  belongs_to :genre, touch: true
  after_touch do
    puts 'A Book was touched'
  end
end

class Genre < ApplicationRecord
  has_many :books
  after_touch :log_when_books_or_library_touched

  private
    def log_when_books_or_library_touched
      puts 'Book/Library was touched'
    end
end

3.3.0 :298 > book = Book.last
  Book Load (0.3ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT $1  [["LIMIT", 1]]
 => 
#<Book:0x0000000120976fc8
... 
3.3.0 :299 > book.touch
  TRANSACTION (0.4ms)  BEGIN
  Book Update (4.0ms)  UPDATE "books" SET "updated_at" = $1 WHERE "books"."id" = $2  [["updated_at", "2024-07-27 09:57:12.914858"], ["id", 10]]
  Genre Load (1.0ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
A Book was touched
  Genre Update (0.4ms)  UPDATE "genres" SET "updated_at" = $1 WHERE "genres"."id" = $2  [["updated_at", "2024-07-27 09:57:12.942200"], ["id", 1]]
Book/Genre was touched
  TRANSACTION (1.4ms)  COMMIT
 => true 



===> Methods that help in Running Callbacks

The following methods trigger callbacks:->
1) create
2) create!
3) destroy
4) destroy!
5) destroy_all
6) destroy_by
7) save
8) save!
9) save(validate: false)
10) save!(validate: false)
11) toggle!
12) touch
13) update_attribute
14) update
15) update!
16) valid?

Additionally, the after_find callback is triggered by the following finder methods:
1) all
2) first
3) find
4) find_by
5) find_by_*
6) find_by_*!
7) find_by_sql
8) last

The after_initialize callback is triggered every time a new object of the class is initialized.



===> Skipping Callbacks
These methods should be used with caution, however, because important business rules and application logic may be kept in callbacks. 
Bypassing them without understanding the potential implications may lead to invalid data.

Just as with validations, it is also possible to skip callbacks by using the following methods:
1) decrement!
2) decrement_counter
3) delete
4) delete_all
5) delete_by
6) increment!
7) increment_counter
8) insert
9) insert!
10) insert_all
11) insert_all!
12) touch_all
13) update_column
14) update_columns
15) update_all
16) update_counters
17) upsert
18) upsert_all



===> Halting Execution
We can halt the execution of a callback chain by using throw(:abort). When a callback throws :abort, it stops the execution of 
subsequent callbacks and prevents the associated action (like save, update, or destroy) from completing.
  throw :abort
The whole callback chain is wrapped in a transaction. 
If any callback raises an exception, the execution chain gets halted and a ROLLBACK is issued. To intentionally stop a chain use:

Example:

class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 10 }
  before_save :check_title
  private
  def check_title
    if title == "Invalid"
      puts "Before Save: Halting save because title is 'Invalid'"
      throw(:abort)
    end
  end
end

3.3.0 :301 > article = Article.new(title: "Invalid", content: "This content is valid.")
A new article is initialized!
 => #<Article:0x00000001214d4190 id: nil, title: "Invalid", content: "This content is valid.", created_at: nil, updated_at: nil, published_at: nil> 
3.3.0 :302 > article.save
Before Save: Halting save because title is 'Invalid'
 => false 

IMPORTANT NOTE: If an ActiveRecord::RecordNotDestroyed is raised within after_destroy, before_destroy or around_destroy     
                callback, it will not be re-raised and the destroy method will return false.




===> Relational Callbacks
In Rails, relational callbacks are callbacks that involve interactions between associated models. 
They allow you to execute code in response to changes in related records, ensuring that your applications state remains consistent across related models.
Callbacks work through model relationships, and can even be defined by them.

Example:
3.3.0 :315 > genre = Genre.find_by(id:3)
  Genre Load (0.8ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 3], ["LIMIT", 1]]
 => #<Genre:0x00000001216f8700 id: 3, genre_name: "literature", created_at: Sat, 27 Jul 2024 10:29:43.465751000 UTC +00:00, updated_at: Sat, 27 Jul 2024 10:29:43.465751000 UTC +00:00> 
3.3.0 :316 > book = genre.books.create(title: "Three men in a Boat" , author_id: 12)
  TRANSACTION (0.6ms)  BEGIN
  Author Load (0.3ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 12], ["LIMIT", 1]]
  Book Create (5.0ms)  INSERT INTO "books" ("isbn", "title", "quantity", "created_at", "updated_at", "available_quantity", "author_id", "genre_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["isbn", nil], ["title", "Three men in a Boat"], ["quantity", nil], ["created_at", "2024-07-27 10:32:11.795965"], ["updated_at", "2024-07-27 10:32:11.795965"], ["available_quantity", nil], ["author_id", 12], ["genre_id", 3]]
  Author Update All (0.7ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) + $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 12]]
  Genre Update (0.4ms)  UPDATE "genres" SET "updated_at" = $1 WHERE "genres"."id" = $2  [["updated_at", "2024-07-27 10:32:11.804774"], ["id", 3]]
Book/Genre was touched
  TRANSACTION (1.3ms)  COMMIT
 => 
#<Book:0x0000000120ad7958
... 
3.3.0 :317 > genre.destroy
  TRANSACTION (0.4ms)  BEGIN
  Book Load (1.8ms)  SELECT "books".* FROM "books" WHERE "books"."genre_id" = $1  [["genre_id", 3]]
  Book Destroy (2.2ms)  DELETE FROM "books" WHERE "books"."id" = $1  [["id", 11]]
  Author Update All (0.3ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) - $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 12]]
Book destroyed
  Genre Destroy (0.5ms)  DELETE FROM "genres" WHERE "genres"."id" = $1  [["id", 3]]
  TRANSACTION (1.0ms)  COMMIT
 => #<Genre:0x00000001216f8700 id: 3, genre_name: "literature", created_at: Sat, 27 Jul 2024 10:29:43.465751000 UTC +00:00, updated_at: Sat, 27 Jul 2024 10:32:55.801353000 UTC +00:00> 




===> Association Callbacks
Association callbacks are similar to normal callbacks, but they are triggered by events in the life cycle of a collection. There are four available association callbacks:

1) before_add
2) after_add
3) before_remove
4) after_remove

Example:
class Author < ApplicationRecord
  has_many :books, before_add: :check_book_limit, after_add: :update_books_count, after_remove: :update_books_count

  private

  def check_book_limit(book)
    if books_count >= 2
      Rails.logger.info "Cannot add book: Limit of 2 books reached."
      throw(:abort) 
    end
  end

  def update_books_count(book)
    update(books_count: books.count)
  end
end

3.3.0 :320 > author = Author.create!(author_name: "John Doe", nationality: "American")
  TRANSACTION (0.2ms)  BEGIN
  Author Create (2.8ms)  INSERT INTO "authors" ("author_name", "nationality", "created_at", "updated_at", "books_count") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["author_name", "John Doe"], ["nationality", "American"], ["created_at", "2024-07-27 10:47:49.391915"], ["updated_at", "2024-07-27 10:47:49.391915"], ["books_count", 0]]
  TRANSACTION (1.2ms)  COMMIT
 => 
#<Author:0x0000000120ebb100
... 
3.3.0 :321 > book1 = Book.create!(isbn: "1234567890", title: "Book One", quantity: 5, available_quantity: 5, author: author, genre_id: 1)
3.3.0 :322 > book2 = Book.create!(isbn: "0987654321", title: "Book Two", quantity: 10, available_quantity: 10, author: author, genre_id: 1)
  TRANSACTION (0.2ms)  BEGIN
  Genre Load (0.5ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  Book Create (0.7ms)  INSERT INTO "books" ("isbn", "title", "quantity", "created_at", "updated_at", "available_quantity", "author_id", "genre_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["isbn", "1234567890"], ["title", "Book One"], ["quantity", 5], ["created_at", "2024-07-27 10:48:15.978257"], ["updated_at", "2024-07-27 10:48:15.978257"], ["available_quantity", 5], ["author_id", 13], ["genre_id", 1]]
  Author Update All (0.3ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) + $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 13]]
  Book Count (1.2ms)  SELECT COUNT(*) FROM "books" WHERE "books"."author_id" = $1  [["author_id", 13]]
  Genre Update (0.3ms)  UPDATE "genres" SET "updated_at" = $1 WHERE "genres"."id" = $2  [["updated_at", "2024-07-27 10:48:15.980864"], ["id", 1]]
Book/Genre was touched
  TRANSACTION (0.7ms)  COMMIT
  TRANSACTION (0.1ms)  BEGIN
  Genre Load (0.2ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  Book Create (0.5ms)  INSERT INTO "books" ("isbn", "title", "quantity", "created_at", "updated_at", "available_quantity", "author_id", "genre_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["isbn", "0987654321"], ["title", "Book Two"], ["quantity", 10], ["created_at", "2024-07-27 10:48:15.986145"], ["updated_at", "2024-07-27 10:48:15.986145"], ["available_quantity", 10], ["author_id", 13], ["genre_id", 1]]
  Author Update All (0.3ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) + $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 13]]
  Book Count (0.3ms)  SELECT COUNT(*) FROM "books" WHERE "books"."author_id" = $1  [["author_id", 13]]
  Genre Update (0.3ms)  UPDATE "genres" SET "updated_at" = $1 WHERE "genres"."id" = $2  [["updated_at", "2024-07-27 10:48:15.987849"], ["id", 1]]
Book/Genre was touched
  TRANSACTION (0.3ms)  COMMIT
 => 
#<Book:0x0000000120f912c8
... 
3.3.0 :323 > new_book = Book.new(isbn: "1111111111", title: "Book Three", quantity: 3,available_quantity: 3, author: author, genre_id: 1)
3.3.0 :324 > 
 => #<Book:0x000000012145f2a0 id: nil, isbn: "1111111111", title: "Book Three", quantity: 3, created_at: nil, updated_at: nil, available_quantity: 3, author_id: 13, genre_id: 1> 
3.3.0 :325 > author.books << new_book 
Cannot add book: Limit of 2 books reached.
  Book Load (1.1ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 /* loading for pp */ LIMIT $2  [["author_id", 13], ["LIMIT", 11]]
 => 
[#<Book:0x0000000121456f60
  id: 12,
  isbn: "1234567890",
  title: "Book One",
  quantity: 5,
  created_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
  updated_at: Sat, 27 Jul 2024 10:48:15.978257000 UTC +00:00,
  available_quantity: 5,
  author_id: 13,
  genre_id: 1>,
 #<Book:0x0000000121456e20
  id: 13,
  isbn: "0987654321",
  title: "Book Two",
  quantity: 10,
  created_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
  updated_at: Sat, 27 Jul 2024 10:48:15.986145000 UTC +00:00,
  available_quantity: 10,
  author_id: 13,
  genre_id: 1>] 




===> Conditional Callbacks

Conditional callbacks in Rails allow you to execute callback methods based on specific conditions. These conditions are specified using the :if and :unless options, 
which can take symbols representing method names, Procs, or arrays of methods and Procs. Heres a detailed guide on how to use them:

1)Using :if and :unless with a Symbol

Example:
class Item < ApplicationRecord
  before_save :apply_discount, if: :expensive?
  before_save :notify_low_stock, unless: :in_stock?

  def apply_discount
    if price > 100
      self.price -= 10
      puts "Discount applied to item: #{name}"
    end
  end
  def notify_low_stock
    if stock < 10
      puts "Low stock warning for item: #{name}"
    end
  end

  private

  def expensive?
    price > 50
  end

  def in_stock?
    stock > 0
  end
end

3.3.0 :328 > item = Item.new(name: "Luxury Item", price: 120, stock: 5, available: true)
 => #<Item:0x0000000121633c98 id: nil, name: "Luxury Item", price: 0.12e3, stock: 5, available: true, created_at: nil, updated_at: nil> 
3.3.0 :329 > item.save
3.3.0 :330 > 
Discount applied to item: Luxury Item
  TRANSACTION (0.4ms)  BEGIN
  Item Create (4.1ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Luxury Item"], ["price", "110.0"], ["stock", 5], ["available", true], ["created_at", "2024-07-27 11:15:13.510127"], ["updated_at", "2024-07-27 11:15:13.510127"]]
  TRANSACTION (0.4ms)  COMMIT
 => true 


2)Using :if and :unless with a Proc

Example:
 class Item < ApplicationRecord
  before_save :apply_discount, if: Proc.new { price > 50 }

  def apply_discount
    if price > 50
      self.price -= 10
      puts "Discount applied to item: #{name}"
    end
  end
end

3.3.0 :332 > item2 = Item.new(name: "Cheap Item", price: 40, stock: 5, available: true)
3.3.0 :333 > item2.save
  TRANSACTION (0.2ms)  BEGIN
  Item Create (1.8ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Cheap Item"], ["price", "40.0"], ["stock", 5], ["available", true], ["created_at", "2024-07-27 11:17:28.658859"], ["updated_at", "2024-07-27 11:17:28.658859"]]
  TRANSACTION (1.2ms)  COMMIT
 => true 
3.3.0 :334 > item3 = Item.new(name: "Expensive Item", price: 120, stock: 5, available: true)
3.3.0 :335 > item3.save
3.3.0 :336 > 
Discount applied to item: Expensive Item
  TRANSACTION (0.4ms)  BEGIN
  Item Create (1.5ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Expensive Item"], ["price", "110.0"], ["stock", 5], ["available", true], ["created_at", "2024-07-27 11:17:33.303071"], ["updated_at", "2024-07-27 11:17:33.303071"]]
  TRANSACTION (0.8ms)  COMMIT
 => true 


3) Multiple Callback Conditions

Example:
class Item < ApplicationRecord
  before_save :filter_content, if: [:expensive?, Proc.new { stock < 10 }]

  def filter_content
    if price > 100
      self.name = "[FILTERED] #{name}"
     puts "Content filtered for item: #{name}"
    end
  end

  def expensive?
    price > 50
  end
end

3.3.0 :338 > item1 = Item.new(name: "Luxury Item", price: 120, stock: 5, available: true)
3.3.0 :339 > item1.save
Content filtered for item: [FILTERED] Luxury Item
  TRANSACTION (0.2ms)  BEGIN
  Item Create (1.0ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "[FILTERED] Luxury Item"], ["price", "120.0"], ["stock", 5], ["available", true], ["created_at", "2024-07-27 11:20:21.395820"], ["updated_at", "2024-07-27 11:20:21.395820"]]
  TRANSACTION (1.3ms)  COMMIT
 => true 
3.3.0 :340 > item2 = Item.new(name: "Affordable Item", price: 40, stock: 5, available: true)
3.3.0 :341 > item2.save
  TRANSACTION (0.4ms)  BEGIN
  Item Create (1.5ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Affordable Item"], ["price", "40.0"], ["stock", 5], ["available", true], ["created_at", "2024-07-27 11:20:25.540650"], ["updated_at", "2024-07-27 11:20:25.540650"]]
  TRANSACTION (1.7ms)  COMMIT
 => true 
3.3.0 :342 > item3 = Item.new(name: "Regular Item", price: 70, stock: 15, available: true)
3.3.0 :343 > item3.save
  TRANSACTION (0.3ms)  BEGIN
  Item Create (0.9ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Regular Item"], ["price", "70.0"], ["stock", 15], ["available", true], ["created_at", "2024-07-27 11:20:30.581363"], ["updated_at", "2024-07-27 11:20:30.581363"]]
  TRANSACTION (0.6ms)  COMMIT
 => true 


4) Using Both :if and :unless

Example:
class Item < ApplicationRecord
  before_save :adjust_price, if: Proc.new { price > 100 }, unless: :in_stock?

  def adjust_price
    self.price -= 10
    puts "Price adjusted for item: #{name}. New price: #{price}"
  end
  
  def in_stock?
    stock > 0
  end
end

3.3.0 :345 > item1 = Item.new(name: "High-End Item", price: 150, stock: 0, available: true)
3.3.0 :346 > item1.save
Price adjusted for item: High-End Item. New price: 140.0
  TRANSACTION (0.2ms)  BEGIN
  Item Create (2.0ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "High-End Item"], ["price", "140.0"], ["stock", 0], ["available", true], ["created_at", "2024-07-27 11:22:40.614121"], ["updated_at", "2024-07-27 11:22:40.614121"]]
  TRANSACTION (1.6ms)  COMMIT
 => true 
3.3.0 :347 > item2 = Item.new(name: "High-End Item in Stock", price: 120, stock: 10, available: true)
3.3.0 :348 > item2.save
  TRANSACTION (0.3ms)  BEGIN
  Item Create (1.1ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "High-End Item in Stock"], ["price", "120.0"], ["stock", 10], ["available", true], ["created_at", "2024-07-27 11:22:44.942192"], ["updated_at", "2024-07-27 11:22:44.942192"]]
  TRANSACTION (1.0ms)  COMMIT
 => true 
3.3.0 :349 > item3 = Item.new(name: "Standard Item", price: 90, stock: 0, available: true)
3.3.0 :350 > item3.save
  TRANSACTION (0.3ms)  BEGIN
  Item Create (0.9ms)  INSERT INTO "items" ("name", "price", "stock", "available", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["name", "Standard Item"], ["price", "90.0"], ["stock", 0], ["available", true], ["created_at", "2024-07-27 11:22:48.996696"], ["updated_at", "2024-07-27 11:22:48.996696"]]
  TRANSACTION (0.5ms)  COMMIT
 => true 





 ===>  Callback Classes
 Sometimes the callback methods that youll write will be useful enough to be reused by other models. 
 Active Record makes it possible to create classes that encapsulate the callback methods, so they can be reused.

 Example:
 class FileDestroyerCallback
  def after_destroy(picture_file)
    puts "File deleted: #{picture_file.filepath}"
    if File.exist?(picture_file.filepath)
      File.delete(picture_file.filepath)
    end
  end

class PictureFile < ApplicationRecord
  after_destroy FileDestroyerCallback.new
end
  
 3.3.0 :370 > picture_file = PictureFile.create(filepath: "Image.jpg")
  TRANSACTION (0.2ms)  BEGIN
  PictureFile Create (1.3ms)  INSERT INTO "picture_files" ("filepath", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["filepath", "Image.jpg"], ["created_at", "2024-07-27 11:56:32.921527"], ["updated_at", "2024-07-27 11:56:32.921527"]]
  TRANSACTION (1.0ms)  COMMIT
 => #<PictureFile:0x000000011fff08a0 id: 4, filepath: "Image.jpg", created_at: Sat, 27 Jul 2024 11:56:32.921527000 UTC +00:00, updated_at: Sat, 27 Jul 2024 11:56:32.921527000 UTC +00:00> 
3.3.0 :371 >  picture_file.destroy
  TRANSACTION (0.3ms)  BEGIN
  PictureFile Destroy (1.2ms)  DELETE FROM "picture_files" WHERE "picture_files"."id" = $1  [["id", 4]]
File deleted: Image.jpg
  TRANSACTION (0.7ms)  COMMIT
 => #<PictureFile:0x000000011fff08a0 id: 4, filepath: "Image.jpg", created_at: Sat, 27 Jul 2024 11:56:32.921527000 UTC +00:00, updated_at: Sat, 27 Jul 2024 11:56:32.921527000 UTC +00:00> 
3.3.0 :372 > 