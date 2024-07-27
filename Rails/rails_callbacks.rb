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