                                                    RAILS ASSOCIATIONS

An association is a connection between two Active Record models. 
We need associations between models Because they make common operations simpler and easier in your code.
These associations help in organizing and querying related data efficiently. 

For example, consider a simple Rails application that includes a model for authors and a model for books. Each author can have many books.
With Active Record associations, we can streamline these - and other - operations by declaratively telling Rails that there is a connection between the two models. 
Heres the code for setting up authors and books:

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  belongs_to :author
end



Here are the key advantages of using associations in Rails:
1) Simplified Data Retrieval:->
    Associations provide methods to easily retrieve related records. For example, with has_many and belongs_to, you can access related objects directly without complex queries.

2) Automatic Joins and Queries:->
    Rails handles database joins and complex queries automatically, saving you from writing raw SQL and ensuring efficient data retrieval.

3) Data Integrity:->
    Associations help maintain data integrity by setting constraints and automatic actions (e.g., dependent: :destroy) that ensure related records are handled properly when a parent record is modified or deleted.

4) Enhanced Readability:->
    Code that uses associations is often more readable and expressive. The relationships between models are clear, making the code easier to understand and maintain.

5) Reduced Boilerplate Code:->
    Associations reduce the amount of boilerplate code needed for managing relationships and performing common operations, leading to cleaner and more concise code.

6) Automatic Foreign Key Management:->
    Rails manages foreign keys and validates relationships, helping to avoid issues related to orphaned records or incorrect foreign key values.

7) Convenient Query Methods:->
    Associations provide built-in query methods that simplify searching and filtering related data, such as where, joins, and includes.

8) Support for Nested Attributes:->
    Associations enable nested attributes, allowing you to create or update associated records in a single operation, which is useful for forms with multiple models.

9) Data Caching:->
    Rails can cache associated records to improve performance, especially when using methods like includes to eager-load related records.

10) Validation Integration:->
    Associations can be used in conjunction with validations to enforce rules about relationships, ensuring that related records are present and valid.




                                                ===> TYPES OF ASSOCIATIONS <===

1) belongs_to -> 
A belongs_to association sets up a connection with another model, such that each instance of the declaring model "belongs to" one instance of the other model. 

Example:
class Book < ApplicationRecord
  belongs_to :author
end


2) has_one -> 
A has_one association indicates that one other model has a reference to this model. That model can be fetched through this association.

Example:
class User < ApplicationRecord
  has_one :account
end


3) has_many -> 
A has_many association is similar to has_one, but indicates a one-to-many connection with another model
This association indicates that each instance of the model has zero or more instances of another model. 

Example:
class Author < ApplicationRecord
  has_many :books
end


4) has_many :through -> 
A has_many :through association is often used to set up a many-to-many connection with another model. 
This association indicates that the declaring model can be matched with zero or more instances of another model by proceeding through a third model. 

Example:
class Document < ApplicationRecord
  has_many :sections
  has_many :paragraphs, through: :sections
end

class Section < ApplicationRecord
  belongs_to :document
  has_many :paragraphs
end

class Paragraph < ApplicationRecord
  belongs_to :section
end


5) has_one :through -> 
A has_one :through association sets up a one-to-one connection with another model. 
This association indicates that the declaring model can be matched with one instance of another model by proceeding through a third model.

Example:
class Supplier < ApplicationRecord
  has_one :account
  has_one :account_history, through: :account
end

class Account < ApplicationRecord
  belongs_to :supplier
  has_one :account_history
end

class AccountHistory < ApplicationRecord
  belongs_to :account
end


6) has_and_belongs_to_many ->
A has_and_belongs_to_many association creates a direct many-to-many connection with another model, with no intervening model. 
This association indicates that each instance of the declaring model refers to zero or more instances of another model.

Example:
class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
end




                                ====>     TIPS , TRICKS & WARNINGS (for effecient use of association in rails)    <====

1) Controlling caching ->
All of the association methods are built around caching, which keeps the result of the most recent query available for further operations. 
The cache is even shared across methods:-

author.books.load                  # retrieves books from the database
author.books.size                  # uses the cached copy of books
author.books.empty?                # uses the cached copy of books
author.books.reload.empty?         # discards the cached copy of books and goes back to the database


2) Avoiding name collisions -> 
We are not free to use just any name for your associations. 
Because creating an association adds a method with that name to the model, it is a bad idea to give an association a name that is already used for an instance method of ActiveRecord::Base. 
The association method would override the base method and break things. 
For instance, attributes or connection are bad names for associations.


3) Updating the schema ->
Associations are extremely useful, but they are not magic. You are responsible for maintaining your database schema to match your associations.
   -> Creating Foreign Keys for belongs_to Associations
        class Book < ApplicationRecord
          belongs_to :author
        end

        class AddAuthorToBooks < ActiveRecord::Migration[7.1]
          def change
            add_reference :books, :author
          end
        end

   -> Creating Join Tables for has_and_belongs_to_many Associations
        class Assembly < ApplicationRecord
          has_and_belongs_to_many :parts
        end

        class Part < ApplicationRecord
          has_and_belongs_to_many :assemblies
        end

        class CreateAssembliesPartsJoinTable < ActiveRecord::Migration[7.1]
          def change
            create_join_table :assemblies, :parts do |t|
              t.index :assembly_id
              t.index :part_id
            end
          end
        end


4) Controlling association scope ->
By default, associations look for objects only within the current modules scope. 
This can be important when you declare Active Record models within a module. 
For example:
module MyApplication
  module Business
    class Supplier < ApplicationRecord
      has_one :account,
        class_name: "MyApplication::Billing::Account"
    end
  end

  module Billing
    class Account < ApplicationRecord
      belongs_to :supplier,
        class_name: "MyApplication::Business::Supplier"
    end
  end
end


5) Bi-directional associations ->
Its normal for associations to work in two directions, requiring declaration on two different models:
Example:
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author
end
Active Record will attempt to automatically identify that these two models share a bi-directional association based on the association name.


IMPORTANT => For belongs_to associations you need to create foreign keys, and for has_and_belongs_to_many associations you need to create the appropriate join table.




                                      ====> Detailed Association Reference <====

1) belongs_to Association Reference ->                    

    a) Methods Added by belongs_to ->

          * association ->
            The association method returns the associated object, if any. If no associated object is found, it returns nil.
                Example:
                  3.3.0 :031 > author = book.author
                  Author Load (0.4ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
                  => 
                  #<Author:0x0000000128fd3ad0

                  3.3.0 :037 > author = book.reload_author
                  Author Load (0.8ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
                  => 
                  #<Author:0x0000000128fd8350

                  3.3.0 :041 > book.reset_author
                  => false 

          * association=(associate) ->
            The association= method assigns an associated object to this object. 
            Behind the scenes, this means extracting the primary key from the associated object and setting this objects foreign key to the same value.
                Example:
                  3.3.0 :039 > book.author = author
                  => 
                  #<Author:0x0000000128fd8350

          * build_association(attributes = {}) ->
            The build_association method returns a new object of the associated type. 
            This object will be instantiated from the passed attributes, and the link through this objects foreign key will be set, but the associated object will not yet be saved.
                Example:
                  3.3.0 :044 > author =  book.build_author(author_name: "HC Verma" , nationality: "Indian")
                  => #<Author:0x000000011dd1c810 id: nil, author_name: "HC Verma", nationality: "Indian", created_at: nil, updated_at: nil> 

          * create_association(attributes = {}) ->
            The create_association method returns a new object of the associated type. 
            This object will be instantiated from the passed attributes, the link through this objects foreign key will be set, 
            and, once it passes all of the validations specified on the associated model, the associated object will be saved.
                Example:
                  3.3.0 :058 > author =  book.create_author(author_name:"MS chauhan", nationality: "Indian")
                  TRANSACTION (0.6ms)  BEGIN
                  Author Create (3.4ms)  INSERT INTO "authors" ("author_name", "nationality", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["author_name", "MS chauhan"], ["nationality", "Indian"], ["created_at", "2024-07-25 10:23:50.376919"], ["updated_at", "2024-07-25 10:23:50.376919"]]
                  TRANSACTION (0.9ms)  COMMIT
                  => 
                  #<Author:0x000000012c1df790

          * create_association!(attributes = {}) -> 
            Does the same as create_association above, but raises ActiveRecord::RecordInvalid if the record is invalid.

          * association_changed? -> 
            The association_changed? method returns true if a new associated object has been assigned and the foreign key will be updated in the next save.
                Example:
                  3.3.0 :059 > book.author_changed?
                   => true 
                  3.3.0 :060 > book.save!
                    TRANSACTION (0.2ms)  BEGIN
                    Book Update (4.2ms)  UPDATE "books" SET "updated_at" = $1, "author_id" = $2 WHERE "books"."id" = $3  [["updated_at", "2024-07-25 10:27:46.230403"], ["author_id", 12], ["id", 2]]
                    TRANSACTION (1.5ms)  COMMIT
                   => true 
                  3.3.0 :061 > book.author_changed?
                   => false 

          * association_previously_changed? ->
            The association_previously_changed? method returns true if the previous save updated the association to reference a new associate object.
                Example:
                  3.3.0 :062 > book.author_previously_changed?
                   => true 


    b) Options for belongs_to

          * :autosave ->
            Automatically saves the associated records when the parent record is saved.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, autosave: true
                  end
            If you create or update a Book instance and modify its associated Author, the Author will be saved automatically.

          * :class_name ->
            Specifies the class name of the association, if it is not the default.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :writer, class_name: 'Author'
                  end
            Here, Book belongs to Author, but we use writer as the association name. :class_name tells Rails to use the Author model for this association.

          * :counter_cache ->
             Automatically maintains a count of the number of associated records in the parent record’s table.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, counter_cache: true
                  end
            If you add books_count to the authors table, Rails will keep this count updated whenever books are added or removed.

          * :default ->
            Provides a default value for the association, used when the association is not explicitly set.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, default: -> { Author.first }
                  end
            If no author is specified, Rails will assign the first Author record as the default.

          * :dependent ->
            Specifies what should happen to associated records when the parent record is destroyed.
                Example:
                  class Author < ApplicationRecord
                    has_many :books, dependent: :destroy
                  end
            If an Author is destroyed, all associated Books will also be destroyed.

          * :ensuring_owner_was ->
            Specifies an instance method to be called on the owner. 
            The method must return true in order for the associated records to be deleted in a background job.
            
          * :foreign_key ->
            Specifies the foreign key column in the associated table.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, foreign_key: 'writer_id'
                  end
                  class Author < ApplicationRecord                    
                    has_many :books, foreign_key: 'writer_id'
                  end
            The Book model uses writer_id instead of the default author_id to refer to Author.                    

          * :foreign_type ->
            Used with polymorphic associations to specify the type column.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :owner, polymorphic: true, foreign_type: 'owner_type'
                  end
            Here, owner_type is the column that stores the type of the polymorphic association.                   

          * :primary_key ->
            Specifies the primary key column in the associated table.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, primary_key: 'uuid'
                  end
                  class Author < ApplicationRecord                    
                    self.primary_key = 'uuid'
                  end
            If Author uses uuid as its primary key instead of the default id, this option is used.                    

          * :inverse_of ->
            Specifies the inverse association to avoid redundant database queries and ensure proper object relationships.
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, inverse_of: :books
                  end
                  class Author < ApplicationRecord
                    has_many :books, inverse_of: :author
                  end
              This ensures that Rails correctly handles bi-directional associations.

          * :optional ->
            Allows the association to be optional, meaning the parent record can exist without the associated record
                Example:
                  class Book < ApplicationRecord
                    belongs_to :author, optional: true
                  end
            A Book can be created without specifying an Author.

          * :polymorphic ->
            Allows the association to refer to more than one model type.
                Example:
                  class Comment < ApplicationRecord
                    belongs_to :commentable, polymorphic: true
                  end
                  class Book < ApplicationRecord
                    has_many :comments, as: :commentable
                  end
                  class Author < ApplicationRecord
                    has_many :comments, as: :commentable
                  end
            A Comment can belong to either a Book or an Author.

          * :required ->
             Ensures that the association is required and cannot be nil
                Example:
                  class Book < ApplicationRecord
                      belongs_to :author, required: true
                  end
              A Book must have an associated Author and cannot be saved without one.

          * :strict_loading ->
            Ensures that associated records are always loaded when accessed, helping to prevent N+1 query problems. 
                  Example:
                    class Book < ApplicationRecord
                      belongs_to :author, strict_loading: true
                    end
            When accessing @book.author, Rails will ensure that the author is loaded immediately.

          * :touch ->
            Updates the timestamp of the associated record whenever the parent record is updated.
                  Example:
                    class Book < ApplicationRecord
                      belongs_to :author, touch: true
                    end
            Whenever a Book is updated, the updated_at timestamp of its Author will also be updated.

          * :validate ->
            Specifies whether the associated record should be validated before saving the parent record.
                  Example:
                    class Book < ApplicationRecord
                      belongs_to :author, validate: true
                    end 
            When saving a Book, Rails will also validate the associated Author.


    c) Scopes for belongs_to
      There may be times when you wish to customize the query used by belongs_to. Such customizations can be achieved via a scope block

      * where ->
        The where method lets you specify the conditions that the associated object must meet.
      * includes ->
        You can use the includes method to specify second-order associations that should be eager-loaded when this association is used.
      * readonly -> 
        If you use readonly, then the associated object will be read-only when retrieved via the association.
      * select -> 
        The select method lets you override the SQL SELECT clause that is used to retrieve data about the associated object. By default, Rails retrieves all columns.
 



2) has_one Association Reference ->
  The has_one association creates a one-to-one match with another model. 
  In database terms, this association says that the other class contains the foreign key. 
  If this class contains the foreign key, then we should use belongs_to instead.

    a) Methods Added by has_one 

      * association -> 
        The association method returns the associated object, if any. If no associated object is found, it returns nil.
        Example:
          3.3.0 :001 > supplier = MyApplication::Business::Supplier.find_by(id: 1)
          3.3.0 :009 > account = supplier.account
           => 
          #<MyApplication::Billing::Account:0x000000011e2ea530
          ... 
          3.3.0 :010 > account
           => 
          #<MyApplication::Billing::Account:0x000000011e2ea530
           id: 1,
           supplier_id: 1,
           account_number: "1234567890",
           created_at: Fri, 26 Jul 2024 05:43:58.867819000 UTC +00:00,
           updated_at: Fri, 26 Jul 2024 05:43:58.867819000 UTC +00:00> 

      * association=(associate) -> 
        The association= method assigns an associated object to this object. 
        Behind the scenes, this means extracting the primary key from this object and setting the associated objects foreign key to the same value.
        Example:
          3.3.0 :011 > supplier = MyApplication::Business::Supplier.find_by(id: 1)
          3.3.0 :012 > supplier.account = account
           => 
          #<MyApplication::Billing::Account:0x000000011e2ea530
          ... 
          3.3.0 :013 > account
           => 
          #<MyApplication::Billing::Account:0x000000011e2ea530
           id: 1,
           supplier_id: 1,
           account_number: "1234567890",
           created_at: Fri, 26 Jul 2024 05:43:58.867819000 UTC +00:00,
           updated_at: Fri, 26 Jul 2024 05:43:58.867819000 UTC +00:00> 

      * build_association(attributes = {}) -> 
        The build_association method returns a new object of the associated type. 
        This object will be instantiated from the passed attributes, and the link through its foreign key will be set, but the associated object will not yet be saved.
        Example:
          3.3.0 :017 > supplier = MyApplication::Business::Supplier.new(name: "Naman dua")
           => #<MyApplication::Business::Supplier:0x000000011f10ec60 id: nil, name: "Naman dua", created_at: nil, updated_at: nil> 
          3.3.0 :018 > account = supplier.build_account(account_number: "624752869698")
           => #<MyApplication::Billing::Account:0x000000011f0830c0 id: nil, supplier_id: nil, account_number: "624752869698", created_at: nil, updated_at: ... 

      * create_association(attributes = {}) -> 
        The create_association method returns a new object of the associated type. 
        This object will be instantiated from the passed attributes, the link through its foreign key will be set, and, 
        once it passes all of the validations specified on the associated model, the associated object will be saved.
        Example:
         => #<MyApplication::Billing::Account:0x000000011f0830c0 id: nil, supplier_id: nil, account_number: "624752869698", created_at: nil, updated_at: ... 
          3.3.0 :020 > account = supplier.create_account(account_number: "624752869698")
          (irb):20:in `<main>`: You cannot call create unless the parent is saved (ActiveRecord::RecordNotSaved)
          3.3.0 :021 > supplier.save!         
            TRANSACTION (0.6ms)  BEGIN
            MyApplication::Business::Supplier Create (7.9ms)  INSERT INTO "suppliers" ("name", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["name", "Naman dua"], ["created_at", "2024-07-26 06:00:54.564481"], ["updated_at", "2024-07-26 06:00:54.564481"]]
            MyApplication::Billing::Account Create (1.6ms)  INSERT INTO "accounts" ("supplier_id", "account_number", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["supplier_id", 2], ["account_number", "624752869698"], ["created_at", "2024-07-26 06:00:54.575831"], ["updated_at", "2024-07-26 06:00:54.575831"]]
            TRANSACTION (1.1ms)  COMMIT
           => true 

      * create_association!(attributes = {}) ->
        Does the same as create_association above, but raises ActiveRecord::RecordInvalid if the record is invalid.

      * reload_association ->
        If the associated object has already been retrieved from the database for this object, the cached version will be returned
        Example:
          3.3.0 :023 > account = supplier.reload_account
           MyApplication::Billing::Account Load (0.6ms)  SELECT "accounts".* FROM "accounts" WHERE "accounts"."supplier_id" = $1 LIMIT $2  [["supplier_id", 2], ["LIMIT", 1]]
           => 
          #<MyApplication::Billing::Account:0x000000011f0c99d0
          ... 

      * reset_association ->
        To unload the cached version of the associated object—forcing the next access, if any, to query it from the database—call #reset_association on the parent object.
        Example:
          3.3.0 :024 > supplier.reset_account
           => nil


    b) Options for has_one

      * :as -> 
        Allows the association to be polymorphic. Use this option to set up polymorphic associations where one model can be associated with multiple other models.
        Example:
          class Comment < ApplicationRecord
            belongs_to :commentable, polymorphic: true
          end
          class Supplier < ApplicationRecord
            has_one :comment, as: :commentable
          end

          3.3.0 :001 > supplier = MyApplication::Business::Supplier.find(1)
          3.3.0 :002 > supplier.create_comment(content: "This is a comment")
            MyApplication::Business::Supplier Load (0.6ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
            MyApplication::Business::Comment Load (1.4ms)  SELECT "comments".* FROM "comments" WHERE "comments"."commentable_id" = $1 AND "comments"."commentable_type" = $2 LIMIT $3  [["commentable_id", 1], ["commentable_type", "MyApplication::Business::Supplier"], ["LIMIT", 1]]
            TRANSACTION (0.1ms)  BEGIN
            MyApplication::Business::Comment Create (1.6ms)  INSERT INTO "comments" ("content", "commentable_type", "commentable_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["content", "This is a comment"], ["commentable_type", "MyApplication::Business::Supplier"], ["commentable_id", 1], ["created_at", "2024-07-26 06:42:25.035439"], ["updated_at", "2024-07-26 06:42:25.035439"]]
            TRANSACTION (1.1ms)  COMMIT
             => 
          #<MyApplication::Business::Comment:0x0000000120884ac0
           id: 1,
           content: "This is a comment",
           commentable_type: "MyApplication::Business::Supplier",
           commentable_id: 1,
           created_at: Fri, 26 Jul 2024 06:42:25.035439000 UTC +00:00,
           updated_at: Fri, 26 Jul 2024 06:42:25.035439000 UTC +00:00> 
  

      * :autosave -> 
        Determines whether the associated record should be automatically saved when the parent record is saved.
          Example:
          class Supplier < ApplicationRecord
            belongs_to :supplier,
              class_name: "MyApplication::Billing::Account"
          end
            3.3.0 :023 > supplier = MyApplication::Business::Supplier.new(name: "Vaibhav")
             => #<MyApplication::Business::Supplier:0x000000012131c5a0 id: nil, name: "Vaibhav", created_at: nil, updated_at: nil> 
            3.3.0 :024 > supplier.build_account(account_number: "1234567890")
            3.3.0 :025 > supplier.save
              TRANSACTION (0.7ms)  BEGIN
              MyApplication::Business::Supplier Create (4.7ms)  INSERT INTO "suppliers" ("name", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["name", "Vaibhav"], ["created_at", "2024-07-26 06:50:23.197746"], ["updated_at", "2024-07-26 06:50:23.197746"]]
              MyApplication::Billing::Account Create (2.2ms)  INSERT INTO "accounts" ("supplier_id", "account_number", "created_at", "updated_at", "accountable_type", "accountable_id") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["supplier_id", 3], ["account_number", "1234567890"], ["created_at", "2024-07-26 06:50:23.205914"], ["updated_at", "2024-07-26 06:50:23.205914"], ["accountable_type", nil], ["accountable_id", nil]]
              TRANSACTION (0.5ms)  COMMIT
             => true 

      * :class_name -> 
        Specifies the class name of the associated model if its different from the default inferred class name.
          Example:
            class Supplier < ApplicationRecord
              belongs_to :supplier,
                class_name: "MyApplication::Billing::Account"
            end

      * :dependent -> 
        Specifies what should happen to the associated record when the parent record is destroyed.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, dependent: :destroy,
                class_name: "MyApplication::Billing::Account"
            end
            3.3.0 :027 > supplier = MyApplication::Business::Supplier.find_by(name: "Vaibhav")
             MyApplication::Business::Supplier Load (0.6ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."name" = $1 LIMIT $2  [["name", "Vaibhav"], ["LIMIT", 1]]
            => 
           #<MyApplication::Business::Supplier:0x0000000120b406d8
           ... 
           3.3.0 :028 > supplier.destroy
             TRANSACTION (0.4ms)  BEGIN
             MyApplication::Billing::Account Load (0.5ms)  SELECT "accounts".* FROM "accounts" WHERE "accounts"."supplier_id" = $1 LIMIT $2  [["supplier_id", 3], ["LIMIT", 1]]
             MyApplication::Billing::Account Destroy (3.6ms)  DELETE FROM "accounts" WHERE "accounts"."id" = $1  [["id", 3]]
             MyApplication::Business::Supplier Destroy (0.9ms)  DELETE FROM "suppliers" WHERE "suppliers"."id" = $1  [["id", 3]]
             TRANSACTION (0.5ms)  COMMIT
            => 
           #<MyApplication::Business::Supplier:0x0000000120b406d8
            id: 3,
            name: "Vaibhav",
            created_at: Fri, 26 Jul 2024 06:50:23.197746000 UTC +00:00,
            updated_at: Fri, 26 Jul 2024 06:50:23.197746000 UTC +00:00> 
           3.3.0 :029 > 



      * :disable_joins -> 
        Disables automatic joins in queries for this association.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, disable_joins: true,
                class_name: "MyApplication::Billing::Account"
            end
            3.3.0 :029 > MyApplication::Business::Supplier.joins(:account)   #(working because disable_joins: true)
             MyApplication::Business::Supplier Load (2.5ms)  SELECT "suppliers".* FROM "suppliers" INNER JOIN "accounts" ON "accounts"."supplier_id" = "suppliers"."id" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
            => 
           [#<MyApplication::Business::Supplier:0x0000000121378d50
             id: 1,
             name: "Paarth Arora",
             created_at: Thu, 25 Jul 2024 09:02:49.323378000 UTC +00:00,
             updated_at: Thu, 25 Jul 2024 09:02:49.323378000 UTC +00:00>,
            #<MyApplication::Business::Supplier:0x0000000121378c10
             id: 2,
             name: "Naman dua",
             created_at: Fri, 26 Jul 2024 06:00:54.564481000 UTC +00:00,
             updated_at: Fri, 26 Jul 2024 06:00:54.564481000 UTC +00:00>] 


      * :ensuring_owner_was -> 
        Ensures that the owner record was not destroyed before saving the associated record.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, ensuring_owner_was: true,,
                class_name: "MyApplication::Billing::Account"
            end
        
      * :foreign_key -> 
        Specifies a custom foreign key for the association.
          Example:  
            class Supplier < ApplicationRecord
              has_one :account, foreign_key: "supplier_id",
                class_name: "MyApplication::Billing::Account"
            end
          3.3.0 :038 > supplier = MyApplication::Business::Supplier.find_by(name: "Naman dua")
             MyApplication::Business::Supplier Load (0.5ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."name" = $1 LIMIT $2  [["name", "Naman dua"], ["LIMIT", 1]]
            => 
           #<MyApplication::Business::Supplier:0x00000001208ea320
           ... 
           3.3.0 :039 > supplier.create_account(account_number: "1234567890")
             TRANSACTION (0.2ms)  BEGIN
             MyApplication::Business::Supplier Load (0.4ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
             MyApplication::Billing::Account Create (2.4ms)  INSERT INTO "accounts" ("supplier_id", "account_number", "created_at", "updated_at", "accountable_type", "accountable_id") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["supplier_id", 2], ["account_number", "1234567890"], ["created_at", "2024-07-26 07:19:37.694900"], ["updated_at", "2024-07-26 07:19:37.694900"], ["accountable_type", nil], ["accountable_id", nil]]
             TRANSACTION (1.3ms)  COMMIT
             MyApplication::Billing::Account Load (0.3ms)  SELECT "accounts".* FROM "accounts" WHERE "accounts"."supplier_id" = $1 LIMIT $2  [["supplier_id", 2], ["LIMIT", 1]]

      * :inverse_of -> 
        Specifies the inverse association to ensure proper loading and consistency.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, inverse_of: :supplier,
                class_name: "MyApplication::Billing::Account"
            end

            class Account < ApplicationRecord
              belongs_to :supplier, inverse_of: :account,
                class_name: "MyApplication::Business::Supplier"
            end

            3.3.0 :041 > supplier = MyApplication::Business::Supplier.new(name: "Vaibhav")
            => #<MyApplication::Business::Supplier:0x0000000122773878 id: nil, name: "Vaibhav", created_at: nil, updated_at: nil> 
           3.3.0 :044 > supplier.save!
             TRANSACTION (0.4ms)  BEGIN
             MyApplication::Business::Supplier Create (4.2ms)  INSERT INTO "suppliers" ("name", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["name", "Vaibhav"], ["created_at", "2024-07-26 07:26:37.973560"], ["updated_at", "2024-07-26 07:26:37.973560"]]
             MyApplication::Billing::Account Load (0.4ms)  SELECT "accounts".* FROM "accounts" WHERE "accounts"."supplier_id" = $1 LIMIT $2  [["supplier_id", 4], ["LIMIT", 1]]
             TRANSACTION (0.8ms)  COMMIT
            => true 
           3.3.0 :045 > account = supplier.create_account(account_number: "1234567890")
             TRANSACTION (0.4ms)  BEGIN
             MyApplication::Billing::Account Create (1.9ms)  INSERT INTO "accounts" ("supplier_id", "account_number", "created_at", "updated_at", "accountable_type", "accountable_id") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["supplier_id", 4], ["account_number", "1234567890"], ["created_at", "2024-07-26 07:26:49.833961"], ["updated_at", "2024-07-26 07:26:49.833961"], ["accountable_type", nil], ["accountable_id", nil]]
             TRANSACTION (1.0ms)  COMMIT
            => 
           #<MyApplication::Billing::Account:0x0000000120be9d78
           ... 
           3.3.0 :046 > puts account.supplier == supplier 
           true
            => nil
        
      * :primary_key -> 
        Specifies a custom primary key for the association.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, primary_key: "custom_id",
                class_name: "MyApplication::Billing::Account"
            end
        
      * :query_constraints -> 
        Specifies constraints to be applied when querying the association.
          Example:  
            class Supplier < ApplicationRecord
              has_one :account, query_constraints: ->(relation) { relation.where("accounts.active = ?", true) },
                class_name: "MyApplication::Billing::Account"
            end

      * :required -> 
        Specifies whether the associated record must be present
          Example;
            class Supplier < ApplicationRecord
              has_one :account, required: true,
                class_name: "MyApplication::Billing::Account"
            end

      * :source -> 
        Specifies the source association when using :through.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, through: :supplier_accounts, source: :account
                class_name: "MyApplication::Billing::Account"
            end

      * :source_type -> 
        Specifies the source type for polymorphic associations
          Example:
            class Supplier < ApplicationRecord
              has_one :comment, as: :commentable, source_type: "Supplier"
            end

      * :strict_loading ->
        Ensures that the association is loaded eagerly to avoid potential N+1 query issues.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, strict_loading: true,
                class_name: "MyApplication::Billing::Account"
            end
            3.3.0 :077 > supplier = MyApplication::Business::Supplier.find_by(name: "Naman dua")
             MyApplication::Business::Supplier Load (0.2ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."name" = $1 LIMIT $2  [["name", "Naman dua"], ["LIMIT", 1]]
            => 
           #<MyApplication::Business::Supplier:0x00000001227f86b8
           ... 
           3.3.0 :078 > supplier.account
           (irb):78:in `<main>`: `MyApplication::Business::Supplier` is marked for strict_loading. The MyApplication::Billing::Account association named `:account` cannot be lazily loaded. (ActiveRecord::StrictLoadingViolationError)
           3.3.0 :079 > supplier = MyApplication::Business::Supplier.includes(:account).find_by(name: "Naman dua")
           3.3.0 :080 > supplier.account
           3.3.0 :081 > 
             MyApplication::Business::Supplier Load (0.6ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."name" = $1 LIMIT $2  [["name", "Naman dua"], ["LIMIT", 1]]
             MyApplication::Billing::Account Load (0.3ms)  SELECT "accounts".* FROM "accounts" WHERE "accounts"."supplier_id" = $1  [["supplier_id", 2]]
            => 
           #<MyApplication::Billing::Account:0x0000000120ca5dc0
            id: 2,
            supplier_id: 2,
            account_number: "624752869698",
            created_at: Fri, 26 Jul 2024 06:00:54.575831000 UTC +00:00,
            updated_at: Fri, 26 Jul 2024 06:00:54.575831000 UTC +00:00,
            accountable_type: nil,
            accountable_id: nil> 
           3.3.0 :082 > 

      * :through ->   
        Specifies an intermediate association to set up the has_one :through relationship.
          Example;
            class Supplier < ApplicationRecord
              has_one :account, through: :supplier_account,
                class_name: "MyApplication::Billing::Account"
            end

      * :touch -> 
        Updates the timestamp on the parent record when the associated record is updated.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, touch: true,
                class_name: "MyApplication::Billing::Account"
            end
          3.3.0 :088 > supplier = MyApplication::Business::Supplier.find_by(name: "Naman dua")
             MyApplication::Business::Supplier Load (0.5ms)  SELECT "suppliers".* FROM "suppliers" WHERE "suppliers"."name" = $1 LIMIT $2  [["name", "Naman dua"], ["LIMIT", 1]]
            => 
           #<MyApplication::Business::Supplier:0x0000000122b15350
           ... 
           3.3.0 :089 > supplier.updated_at
            => Fri, 26 Jul 2024 06:00:54.564481000 UTC +00:00            

      * :validate -> 
        Specifies whether the associated record should be validated before saving.
          Example:
            class Supplier < ApplicationRecord
              has_one :account, validate: true,
                class_name: "MyApplication::Billing::Account"
            end


    c) Scopes for has_one
        There may be times when you wish to customize the query used by has_one. Such customizations can be achieved via a scope block. 
          For example:  
            class Supplier < ApplicationRecord
              has_one :account, -> { where active: true }
            end

        You can use any of the standard querying methods inside the scope block.
          * where -> 
            The where method lets you specify the conditions that the associated object must meet.

          * includes -> 
            We can use the includes method to specify second-order associations that should be eager-loaded when this association is used
              Example:
                class Supplier < ApplicationRecord
                  has_one :account, -> { includes :representative }
                end
                class Account < ApplicationRecord
                  belongs_to :supplier
                  belongs_to :representative
                end
                class Representative < ApplicationRecord
                  has_many :accounts
                end

          * readonly -> 
            If we use the readonly method, then the associated object will be read-only when retrieved via the association.

          * select ->
            The select method lets you override the SQL SELECT clause that is used to retrieve data about the associated object. By default, Rails retrieves all columns




3) has_many Association Reference ->
    The has_many association creates a one-to-many relationship with another model. 
    In database terms, this association says that the other class will have a foreign key that refers to instances of this class.

    a) Methods Added by has_many ->

        * collection =>
          The collection method returns a Relation of all of the associated objects. If there are no associated objects, it returns an empty Relation.
          Example:
            3.3.0 :251 > author = Author.last
              Author Load (0.5ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" DESC LIMIT $1  [["LIMIT", 1]]
             => 
            #<Author:0x00000001229f7d10
            ... 
            3.3.0 :252 > books = author.books
              Book Load (1.2ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 /* loading for pp */ LIMIT $2  [["author_id", 12], ["LIMIT", 11]]
             => 
            [#<Book:0x00000001221918d8
            ... puts book2.valid? puts author.books

        * collection<<(object, ...)  =>
          The collection<< method adds one or more objects to the collection by setting their foreign keys to the primary key of the calling model.
          Example:
            3.3.0 :261 > book2 = Book.create(title: "Harry Potter and the Chamber of Secres", author: author)
             => 
            #<Book:0x00000001229dab48
            ... 
            3.3.0 :262 > puts author.books
            #<Book:0x00000001229b5780>
            #<Book:0x0000000122376cc0>
            #<Book:0x00000001229dcf88>
             => nil 
            3.3.0 :263 > author.books << book2
             => nil 
            3.3.0 :264 > puts author.books
            #<Book:0x00000001229b5780>
            #<Book:0x0000000122376cc0>
            #<Book:0x00000001229dcf88>
            #<Book:0x00000001229dab48>
             => nil 

        * collection.delete(object, ...)  =>
          The collection.delete method removes one or more objects from the collection by setting their foreign keys to NULL.
          Example:
            3.3.0 :265 > author.books.delete(book2)
             => 
            [#<Book:0x00000001229dab48
              id: nil,
              isbn: nil,
              title: "Harry Potter and the Chamber of Secres",
              quantity: nil,
              created_at: nil,
              updated_at: nil,
              available_quantity: nil,
              author_id: 12,
              genre_id: nil>] 

  IMP: Additionally, objects will be destroyed if they're associated with dependent: :destroy, and deleted if they're associated with dependent: :delete_all.

        * collection.destroy(object, ...) =>
          The collection.destroy method removes one or more objects from the collection by running destroy on each object.
          Example:
            3.3.0 :006 > author.books.destroy(book2)
              TRANSACTION (0.4ms)  BEGIN
              Book Destroy (6.3ms)  DELETE FROM "books" WHERE "books"."id" = $1  [["id", 3]]
              Author Update All (0.6ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) - $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 12]]
              TRANSACTION (0.9ms)  COMMIT
             => 
            [#<Book:0x000000011e73ac98
              id: 3,
              isbn: nil,
              title: "Harry Potter and the Chamber of Secrets",
              quantity: nil,
              created_at: Fri, 26 Jul 2024 09:10:47.753480000 UTC +00:00,
              updated_at: Fri, 26 Jul 2024 09:10:47.753480000 UTC +00:00,
              available_quantity: nil,
              author_id: 12,
              genre_id: 2>] 

        * collection=(objects) =>
          The collection= method makes the collection contain only the supplied objects, by adding and deleting as appropriate. The changes are persisted to the database.
          Example:
            3.3.0 :007 > author.books.pluck(:title)
              Book Pluck (0.7ms)  SELECT "books"."title" FROM "books" WHERE "books"."author_id" = $1  [["author_id", 12]]
             => ["Fundamental of physics"]

        * collection_singular_ids =>
          The collection_singular_ids method returns an array of the ids of the objects in the collection.
          Example:
            3.3.0 :009 > book_ids = author.book_ids
              Book Pluck (0.6ms)  SELECT "books"."id" FROM "books" WHERE "books"."author_id" = $1  [["author_id", 12]]
             => [2] 

        * collection_singular_ids=(ids) =>
          The collection_singular_ids= method makes the collection contain only the objects identified by the supplied primary key values, by adding and deleting as appropriate. 
          The changes are persisted to the database.
          Example:  
            3.3.0 :029 > puts author.books.pluck(:title)
            Harry Potter and the Philosophers Stone
            Harry Potter and the Chamber of Secrets
            Harry Potter and the Prisoner of Azkaban

        * collection.clear =>
          The collection.clear method removes all objects from the collection according to the strategy specified by the dependent option. 
          If no option is given, it follows the default strategy. 
          The default strategy for has_many :through associations is delete_all, and for has_many associations is to set the foreign keys to NULL.
          Example:
            3.3.0 :034 > author.books.clear
            3.3.0 :035 > 
              Book Delete All (2.3ms)  DELETE FROM "books" WHERE "books"."author_id" = $1  [["author_id", 10]]
              Author Update All (0.5ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) - $1 WHERE "authors"."id" = $2  [["books_count", 3], ["id", 10]]
             => [] 

        * collection.empty? => 
          The collection.empty? method returns true if the collection does not contain any associated objects.
          Example:
            3.3.0 :036 > author.books.empty?
             => true 

        * collection.size => 
          The collection.size method returns the number of objects in the collection.
          Example:
            3.3.0 :037 > book_count = author.books.size
             => 0 

        * collection.find(...) => 
          The collection.find method finds objects within the collections table.
          Example:
            3.3.0 :008 > available_books = author.books.find(8)
              Book Load (0.9ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 AND "books"."id" = $2 LIMIT $3  [["author_id", 10], ["id", 8], ["LIMIT", 1]]
             => 
            #<Book:0x0000000120c6bcd8
            ... 

        * collection.where(...) => 
          The collection.where method finds objects within the collection based on the conditions supplied but the objects are loaded lazily 
          meaning that the database is queried only when the object(s) are accessed.
          Example:
            3.3.0 :009 > available_books = author.books.where(genre_id:2)
              Book Load (0.7ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 AND "books"."genre_id" = $2 /* loading for pp */ LIMIT $3  [["author_id", 10], ["genre_id", 2], ["LIMIT", 11]]
             => 
            [#<Book:0x0000000120d299e0
            ... 
            3.3.0 :010 > available_book = available_books.first
              Book Load (0.8ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1 AND "books"."genre_id" = $2 ORDER BY "books"."id" ASC LIMIT $3  [["author_id", 10], ["genre_id", 2], ["LIMIT", 1]]
             => 
            #<Book:0x0000000120d257a0

        * collection.exists?(...) => 
          The collection.exists? method checks whether an object meeting the supplied conditions exists in the collections table.
          Example:
            3.3.0 :013 > author.books.exists?(title: "Harry Potter and the Chamber of Secrets")
            Book Exists? (2.2ms)  SELECT 1 AS one FROM "books" WHERE "books"."author_id" = $1 AND "books"."title" = $2 LIMIT $3  [["author_id", 10], ["title", "Harry Potter and the Chamber of Secrets"], ["LIMIT", 1]]
           => true 

        * collection.build(attributes = {}) => 
          The collection.build method returns a single or array of new objects of the associated type. 
          The object(s) will be instantiated from the passed attributes, and the link through their foreign key will be created, but the associated objects will not yet be saved.
          Example:
            3.3.0 :014 > author.books.size
             => 7 
             3.3.0 :015 > books= author.books.build([{title: "The Casual Vacancy", genre_id:1},{title:"The Shining", genre_id:1}])
             => 
            [#<Book:0x0000000121a51050
            ... 
            3.3.0 :017 > author.books.size
             => 7 

        * collection.create(attributes = {}) => 
          The collection.create method returns a single or array of new objects of the associated type.
          Example:
            3.3.0 :019 > author = Author.find_by(id:10)
              Author Load (0.5ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = $1 LIMIT $2  [["id", 10], ["LIMIT", 1]]
             => 
            #<Author:0x0000000121757200
            ... 
            3.3.0 :020 > books= author.books.create([{title: "The Casual Vacancy", genre_id:1},{title:"The Shining", genre_id:1}])
              TRANSACTION (0.2ms)  BEGIN
              Genre Load (0.4ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
              Book Create (0.8ms)  INSERT INTO "books" ("isbn", "title", "quantity", "created_at", "updated_at", "available_quantity", "author_id", "genre_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["isbn", nil], ["title", "The Casual Vacancy"], ["quantity", nil], ["created_at", "2024-07-26 09:46:40.502867"], ["updated_at", "2024-07-26 09:46:40.502867"], ["available_quantity", nil], ["author_id", 10], ["genre_id", 1]]
              Author Update All (0.3ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) + $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 10]]
              TRANSACTION (1.3ms)  COMMIT
              TRANSACTION (0.1ms)  BEGIN
              Genre Load (0.2ms)  SELECT "genres".* FROM "genres" WHERE "genres"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
              Book Create (0.5ms)  INSERT INTO "books" ("isbn", "title", "quantity", "created_at", "updated_at", "available_quantity", "author_id", "genre_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["isbn", nil], ["title", "The Shining"], ["quantity", nil], ["created_at", "2024-07-26 09:46:40.507857"], ["updated_at", "2024-07-26 09:46:40.507857"], ["available_quantity", nil], ["author_id", 10], ["genre_id", 1]]
              Author Update All (0.3ms)  UPDATE "authors" SET "books_count" = COALESCE("books_count", 0) + $1 WHERE "authors"."id" = $2  [["books_count", 1], ["id", 10]]
              TRANSACTION (0.3ms)  COMMIT
             => 
            [#<Book:0x0000000121832918

        * collection.create!(attributes = {}) =>
          Does the same as collection.create above, but raises ActiveRecord::RecordInvalid if the record is invalid

        * collection.reload =>
          The collection.reload method returns a Relation of all of the associated objects, forcing a database read. 
                      If there are no associated objects, it returns an empty Relation. 
          Example:
            3.3.0 :021 > books = author.books.reload
              Book Load (0.8ms)  SELECT "books".* FROM "books" WHERE "books"."author_id" = $1  [["author_id", 10]]
             => 
            [#<Book:0x00000001219912c8


    b) Options for has_many ->
      While Rails uses intelligent defaults that will work well in most situations, there may be times when you want to customize the behavior 
      of the has_many association reference. Such customizations can easily be accomplished by passing options when you create the association.
      The has_many association supports these options:
        * :as
        * :autosave
        * :class_name
        * :counter_cache
        * :dependent
        * :disable_joins
        * :ensuring_owner_was
        * :extend
        * :foreign_key
        * :foreign_type
        * :inverse_of
        * :primary_key
        * :query_constraints
        * :source
        * :source_type
        * :strict_loading
        * :through
        * :validate

    
    c) Scopes for has_many -> 
     There may be times when you wish to customize the query used by has_many. Such customizations can be achieved via a scope block.
      Example:
      class Author < ApplicationRecord
        has_many :books, -> { where processed: true }
      end

      We can use any of the standard querying methods inside the scope block. The following ones are discussed below:
       * where =>
        The where method lets you specify the conditions that the associated object must meet.
        Example:
        class Author < ApplicationRecord
          has_many :confirmed_books, -> { where "confirmed = 1" },
            class_name: "Book"
        end

       * extending => 
        The extending method specifies a named module to extend the association proxy.

       * group => 
        The group method supplies an attribute name to group the result set by, using a GROUP BY clause in the finder SQL.
        Example:
        class Author < ApplicationRecord
          has_many :chapters, -> { group 'books.id' },
                              through: :books
        end

       * includes => 
       You can use the includes method to specify second-order associations that should be eager-loaded when this association is used
       Example:  
        class Author < ApplicationRecord
          has_many :books
        end
        class Book < ApplicationRecord
          belongs_to :author
          has_many :chapters
        end
        class Chapter < ApplicationRecord
          belongs_to :book
        end

       * limit =>
       The limit method lets you restrict the total number of objects that will be fetched through an association.
        Example:  
        class Author < ApplicationRecord
          has_many :recent_books,
            -> { order('published_at desc').limit(100) },
            class_name: "Book"
        end

       * offset =>
       The offset method lets you specify the starting offset for fetching objects via an association. 
       Example: 
         -> { offset(11) } will skip the first 11 records

       * order => 
       The order method dictates the order in which associated objects will be received
        Example:
        class Author < ApplicationRecord
          has_many :books, -> { order "date_confirmed DESC" }
        end

       * readonly => 
       If you use the readonly method, then the associated objects will be read-only when retrieved via the association.
        Example:  
          3.3.0 :022 > author = Author.readonly.last
          Author Load (16.1ms)  SELECT "authors".* FROM "authors" ORDER BY "authors"."id" DESC LIMIT $1  [["LIMIT", 1]]
           => 
          #<Author:0x0000000121b7e248
          ... 

       * select =>
       The select method lets you override the SQL SELECT clause that is used to retrieve data about the associated objects. 
       By default, Rails retrieves all columns.
        
       * distinct =>
       Use the distinct method to keep the collection free of duplicates. This is mostly useful together with the :through option.

      
      
        
4) has_and_belongs_to_many Association Reference ->
    The has_and_belongs_to_many association creates a many-to-many relationship with another model. 
    In database terms, this associates two classes via an intermediate join table that includes foreign keys referring to each of the classes.

    a) Methods Added by has_and_belongs_to_many ->
      * collection =>
        The collection method returns a Relation of all of the associated objects. If there are no associated objects, it returns an empty Relation.
        Example:
          3.3.0 :033 > part = Part.first
            Part Load (0.7ms)  SELECT "parts".* FROM "parts" ORDER BY "parts"."id" ASC LIMIT $1  [["LIMIT", 1]]
          => #<Part:0x0000000121b77088 id: 1, part_number: "Part 1", created_at: Fri, 26 Jul 2024 10:34:19.647603000 
          UTC +00:00, updated_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC... 
          3.3.0 :034 > assemblies = part.assemblies
            Assembly Load (0.7ms)  SELECT "assemblies".* FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id" 
            WHERE "assemblies_parts"."part_id" = $1 /* loading for pp */ LIMIT $2  [["part_id", 1], ["LIMIT", 11]]
          => 
          [#<Assembly:0x00000001215f6e38
          ... 
      
      * collection<<(object, ...) =>
        The collection<< method adds one or more objects to the collection by creating records in the join table.
        Example:
          3.3.0 :029 > part1 = Part.create(part_number: 'Part 1')
            TRANSACTION (0.2ms)  BEGIN
            Part Create (4.5ms)  INSERT INTO "parts" ("part_number", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["part_number", "Part 1"], 
            ["created_at", "2024-07-26 10:34:19.647603"], ["updated_at", "2024-07-26 10:34:19.647603"]]
            TRANSACTION (0.3ms)  COMMIT
            => #<Part:0x0000000121d58870 id: 1, part_number: "Part 1", created_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC +00:00, updated_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC... 
          3.3.0 :030 > assembly1.parts << part1
            TRANSACTION (0.4ms)  BEGIN
            Assembly::HABTM_Parts Create (1.9ms)  INSERT INTO "assemblies_parts" ("assembly_id", "part_id") VALUES ($1, $2)  [["assembly_id", 1], ["part_id", 1]]
            TRANSACTION (0.5ms)  COMMIT
            Part Load (0.8ms)  SELECT "parts".* FROM "parts" INNER JOIN "assemblies_parts" ON "parts"."id" = "assemblies_parts"."part_id" 
            WHERE "assemblies_parts"."assembly_id" = $1 /* loading for pp */ LIMIT $2  [["assembly_id", 1], ["LIMIT", 11]]
            => [#<Part:0x000000012199ca88 id: 1, part_number: "Part 1", created_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC +00:00, updated_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC +00:00>] 

      * collection.delete(object, ...) =>
        The collection.delete method removes one or more objects from the collection by deleting records in the join table. This does not destroy the objects.
        Example:
          3.3.0 :043 > assembly2 = Assembly.create(name: 'Assembly 2')
            TRANSACTION (0.9ms)  BEGIN
            Assembly Create (3.8ms)  INSERT INTO "assemblies" ("name", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["name", "Assembly 2"], 
            ["created_at", "2024-07-26 11:05:51.496763"], ["updated_at", "2024-07-26 11:05:51.496763"]]
            TRANSACTION (1.7ms)  COMMIT
           => #<Assembly:0x000000012199c588 id: 2, name: "Assembly 2", created_at: Fri, 26 Jul 2024 11:05:51.496763000 UTC +00:00, updated_at: Fri, 26 Jul 2024 11:05:51.496763000 UT... 
          3.3.0 :044 > part.assemblies.delete(assembly2)
            TRANSACTION (0.3ms)  BEGIN
            Part::HABTM_Assemblies Delete All (1.8ms)  DELETE FROM "assemblies_parts" WHERE "assemblies_parts"."part_id" = $1 AND 
            "assemblies_parts"."assembly_id" = $2  [["part_id", 1], ["assembly_id", 2]]
             TRANSACTION (0.3ms)  COMMIT
          => 
          [#<Assembly:0x000000012199c588
          id: 2,
          name: "Assembly 2",
          created_at: Fri, 26 Jul 2024 11:05:51.496763000 UTC +00:00,
          updated_at: Fri, 26 Jul 2024 11:05:51.496763000 UTC +00:00>] 

      * collection.destroy(object, ...) =>
        The collection.destroy method removes one or more objects from the collection by deleting records in the join table. This does not destroy the objects.
        Example:
        3.3.0 :045 > part.assemblies.destroy(assembly2)
        3.3.0 :046 > 
          TRANSACTION (0.8ms)  BEGIN
          HABTM_Assemblies Load (0.8ms)  SELECT "assemblies_parts".* FROM "assemblies_parts" WHERE "assemblies_parts"."part_id" = $1 AND "assemblies_parts"."assembly_id" = $2  [["part_id", 1], ["assembly_id", 2]]
          Part::HABTM_Assemblies Delete All (0.7ms)  DELETE FROM "assemblies_parts" WHERE "assemblies_parts"."part_id" = $1 AND "assemblies_parts"."assembly_id" = $2  [["part_id", 1], ["assembly_id", 2]]
          TRANSACTION (0.2ms)  COMMIT
         => 
        [#<Assembly:0x000000012199c588
          id: 2,
          name: "Assembly 2",
          created_at: Fri, 26 Jul 2024 11:05:51.496763000 UTC +00:00,
          updated_at: Fri, 26 Jul 2024 11:05:51.496763000 UTC +00:00>] 

      * collection=(objects) =>
        The collection= method makes the collection contain only the supplied objects, by adding and deleting as appropriate. The changes are persisted to the database.

      * collection_singular_ids => 
        The collection_singular_ids method returns an array of the ids of the objects in the collection.
        Example:
          3.3.0 :045 > part = Part.first
            Part Load (0.7ms)  SELECT "parts".* FROM "parts" ORDER BY "parts"."id" ASC LIMIT $1  [["LIMIT", 1]]
          => #<Part:0x0000000121b77088 id: 1, part_number: "Part 1", created_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC +00:00, updated_at: Fri, 26 Jul 2024 10:34:19.647603000 UTC...
          3.3.0 :046 > assembly_ids = part.assembly_ids
          => [1] 

      * collection_singular_ids=(ids) =>
        The collection_singular_ids= method makes the collection contain only the objects identified by the supplied primary key values, 
        by adding and deleting as appropriate. The changes are persisted to the database.

      * collection.clear =>
        The collection.clear method removes every object from the collection by deleting the rows from the joining table. 
        This does not destroy the associated objects.
        Example:
        3.3.0 :047 > assembly2.parts.clear
          Part Load (1.4ms)  SELECT "parts".* FROM "parts" INNER JOIN "assemblies_parts" ON "parts"."id" = "assemblies_parts"."part_id" 
          WHERE "assemblies_parts"."assembly_id" = $1  [["assembly_id", 2]]
          Assembly::HABTM_Parts Delete All (0.9ms)  DELETE FROM "assemblies_parts" WHERE "assemblies_parts"."assembly_id" = $1 AND 1=0  [["assembly_id", 2]]
        => [] 

      * collection.empty? =>
        The collection.empty? method returns true if the collection does not contain any associated objects.
        Example:
          3.3.0 :035 > part.assemblies.empty?
            Assembly Exists? (4.1ms)  SELECT 1 AS one FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id" 
            WHERE "assemblies_parts"."part_id" = $1 LIMIT $2  [["part_id", 1], ["LIMIT", 1]]
          => false 

      * collection.size => 
        The collection.size method returns the number of objects in the collection.
        Example:
          3.3.0 :036 > assembly_count = part.assemblies.count
            Assembly Count (2.6ms)  SELECT COUNT(*) FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id" 
            WHERE "assemblies_parts"."part_id" = $1  [["part_id", 1]]
          => 1 
      
      * collection.find(...) => 
        The collection.find method finds objects within the collections table.
        Example:
          3.3.0 :037 > assembly = part.assemblies.find(1)
            Assembly Load (0.9ms)  SELECT "assemblies".* FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id"
            WHERE "assemblies_parts"."part_id" = $1 AND "assemblies"."id" = $2 LIMIT $3  [["part_id", 1], ["id", 1], ["LIMIT", 1]]
          => #<Assembly:0x0000000121b7e108 id: 1, name: "Assembly 1", created_at: Fri, 26 Jul 2024 10:33:19.061477000 UTC +00:00, updated_at: Fri, 26 Jul 2024 10:33:19.061477000 UT...

      * collection.where(...) =>  
        The collection.where method finds objects within the collection based on the conditions supplied but the objects 
        are loaded lazily meaning that the database is queried only when the object(s) are accessed.
        Example:
          3.3.0 :038 > new_assemblies = part.assemblies.where("created_at > ?", 2.days.ago)
            Assembly Load (4.9ms)  SELECT "assemblies".* FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id" 
            WHERE "assemblies_parts"."part_id" = $1 AND (created_at > '2024-07-24 10:55:15.203821') /* loading for pp */ LIMIT $2  [["part_id", 1], ["LIMIT", 11]]
          => 
          [#<Assembly:0x0000000121af7e50
          ... 

      * collection.exists?(...) => 
        The collection.exists? method checks whether an object meeting the supplied conditions exists in the collections table.
        Example:
          3.3.0 :041 > Assembly.exists?(name: 'Assembly 1')
            Assembly Exists? (2.0ms)  SELECT 1 AS one FROM "assemblies" WHERE "assemblies"."name" = $1 LIMIT $2  [["name", "Assembly 1"], ["LIMIT", 1]]
          => true 

      * collection.build(attributes = {}) => 
        The collection.build method returns a new object of the associated type. 
        This object will be instantiated from the passed attributes, and the link through the join table will be created, but the associated object will not yet be saved.
        Example:
        3.3.0 :048 > part = assembly2.parts.build(part_number: 'Part 3')
         => #<Part:0x0000000121995c88 id: nil, part_number: "Part 3", created_at: nil, updated_at: nil> 
        3.3.0 :049 > part.new_record?
         => true 

      * collection.create(attributes = {}) => 
        The collection.create method returns a new object of the associated type. 
        This object will be instantiated from the passed attributes, the link through the join table will be created,
        and, once it passes all of the validations specified on the associated model, the associated object will be saved.
        Example:
        3.3.0 :050 > part = assembly2.parts.create(part_number: 'Part 4')
          TRANSACTION (0.9ms)  BEGIN
          Part Create (4.1ms)  INSERT INTO "parts" ("part_number", "created_at", "updated_at") VALUES ($1, $2, $3) 
          RETURNING "id"  [["part_number", "Part 4"], ["created_at", "2024-07-26 11:11:49.428690"], ["updated_at", "2024-07-26 11:11:49.428690"]]
          Assembly::HABTM_Parts Create (0.4ms)  INSERT INTO "assemblies_parts" ("assembly_id", "part_id") VALUES ($1, $2)  [["assembly_id", 2], ["part_id", 2]]
          TRANSACTION (1.5ms)  COMMIT
         => #<Part:0x0000000121b7fc88 id: 2, part_number: "Part 4", created_at: Fri, 26 Jul 2024 11:11:49.428690000 UTC +00:00, updated_at: Fri, 26 Jul 2024 11:11:49.428690000 UTC... 
        3.3.0 :051 > part.persisted?
         => true 

      * collection.create!(attributes = {}) => 
        Does the same as collection.create, but raises ActiveRecord::RecordInvalid if the record is invalid

      * collection.reload =>
        The collection.reload method returns a Relation of all of the associated objects, forcing a database read. 
        If there are no associated objects, it returns an empty Relation.
        Example:
          3.3.0 :039 > assemblies = part.assemblies.reload
            Assembly Load (1.1ms)  SELECT "assemblies".* FROM "assemblies" INNER JOIN "assemblies_parts" ON "assemblies"."id" = "assemblies_parts"."assembly_id"
            WHERE "assemblies_parts"."part_id" = $1  [["part_id", 1]]
           => 
          [#<Assembly:0x0000000121b57a80
          ... 
    