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
       Article Create (6.2ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Untitled"], ["content", "This is some content."], ["created_at", "2024-07-27 07:59:23.935535"], ["updated_at", "2024-07-27 07:59:23.935535"]]
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
       Article Create (2.8ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:07:04.150654"], ["updated_at", "2024-07-27 08:07:04.150654"]]
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
        Article Create (2.1ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Test Title"], ["content", "This is some content."], ["created_at", "2024-07-27 08:10:04.125095"], ["updated_at", "2024-07-27 08:10:04.125095"]]
      Around Save: After Save
      After Save: Updated search index
        TRANSACTION (1.4ms)  COMMIT
       => true     
