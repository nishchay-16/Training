ACTIVE RECORD VALIDATIONS:-

Validations are used to ensure that only valid data is saved into your database. 
For example, it may be important to your application to ensure that every user provides a valid email address and mailing address.

class Librarian < ApplicationRecord
    validates :librarian_name, presence: true
end

irb> Librarian.create(librarian_name: "Nishchay").valid?
=> true
irb> Librarian.create(librarian_name: nil).valid?
=> false



WHY WE USE VALIDATIONS:-
1) Data Integrity:->  Validations ensure that only valid data is saved into the database. 
    For example, ensuring that email addresses are properly formatted or that required fields are not left blank.

2) Business Logic Enforcement:-> They help enforce business rules. 
    For instance, an e-commerce application might require that the quantity of items ordered cannot exceed the quantity in stock.

3) Preventing Invalid Data Entry:-> By validating data before saving it to the database, you can prevent invalid or corrupted data from being persisted. 
    This makes sure that your database contains only valid and meaningful data.

4) User Experience:-> Validations provide feedback to users. 
    If a user submits a form with invalid data, validations can generate error messages that inform the user what needs to be corrected.

5) Security:->  Validations can help prevent malicious data from being saved. 
    For example, validating input length and format can help prevent certain types of injection attacks.

6) Database Efficiency:-> By catching errors at the model level, you reduce the risk of encountering database errors, which can be more costly to handle. 
    This also helps in maintaining the consistency of the database.

7)Simplifies Code Maintenance:-> Centralizing validation logic within models makes the codebase easier to maintain and understand. 
    This keeps your controllers and views cleaner, adhering to the MVC architecture.



===>     VALIDATION HELPERS:-

1) acceptance -> This method validates that a checkbox on the user interface was checked when a form was submitted.



2) confirmation ->

--> validates :email, confirmation: true
    validates :email_confirmation, presence: true
Example:
3.3.0 :112 > a.email_confirmation="Naman@gmail.com"
 => "Naman@gmail.com" 
3.3.0 :113 > a.save
 => false 
3.3.0 :114 > a.save!
(irb):114:in `<main>`: Validation failed: Email confirmation doesnt match Email (ActiveRecord::RecordInvalid)



3) comparison ->

--> :greater_than - Specifies the value must be greater than the supplied value. The default error message for this option is "must be greater than %{count}".
Example:
# validates :number_of_books, comparison: { greater_than: 0}
3.3.0 :035 > a = Librarian.find_by(email: 'n@g.com')
  Librarian Load (0.5ms)  SELECT "librarians".* FROM "librarians" WHERE "librarians"."email" = $1 LIMIT $2  [["email", "n@g.com"], ["LIMIT", 1]]
 => 
3.3.0 :036 > a.number_of_books=0
 => 0 
3.3.0 :037 > a.save
 => false 
3.3.0 :038 > a.save!
(irb):38:in `<main>`: Validation failed: Number of books must be greater than 0 (ActiveRecord::RecordInvalid)


--> :greater_than_or_equal_to - Specifies the value must be greater than or equal to the supplied value. The default error message for this option is "must be greater than or equal to %{count}".
Example:
# validates :number_of_books, comparison: { greater_than_or_equal_to: 1}
3.3.0 :053 > a.number_of_books=0
 => 0 
3.3.0 :054 > a.save!
(irb):54:in `<main>`: Validation failed: Number of books must be greater than or equal to 1 (ActiveRecord::RecordInvalid)


--> :equal_to - Specifies the value must be equal to the supplied value. The default error message for this option is "must be equal to %{count}".
Example:


:less_than - Specifies the value must be less than the supplied value. The default error message for this option is "must be less than %{count}".
Example:
# validates :number_of_books, comparison: { less_than: 1000}
3.3.0 :053 > a.number_of_books=1001
 => 1001
3.3.0 :054 > a.save!
(irb):54:in `<main>`: Validation failed: Number of books must be less than 1000 (ActiveRecord::RecordInvalid)


:less_than_or_equal_to - Specifies the value must be less than or equal to the supplied value. The default error message for this option is "must be less than or equal to %{count}".
Example:
# validates :number_of_books, comparison: { less_than_or_equal_to: 1000}
3.3.0 :053 > a.number_of_books=1001
 => 1001
3.3.0 :054 > a.save!
(irb):54:in `<main>`: Validation failed: Number of books must be less than or equal to 1000 (ActiveRecord::RecordInvalid)


:other_than - Specifies the value must be other than the supplied value. The default error message for this option is "must be other than %{count}".
Example:
# validates :number_of_books, comparison: { greater_than: 0, message: "must be greater than 0" }
3.3.0 :053 > a.number_of_books=0
 => 0 
3.3.0 :054 > a.save!
(irb):54:in `<main>`: Validation failed: Number of books must be greater than 0 (ActiveRecord::RecordInvalid)



4) Format ->

# validates :librarian_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
Example:
3.3.0 :061 > a.librarian_name="Nishchay1"
3.3.0 :062 > 
 => "Nishchay1" 
3.3.0 :063 > a.save!
(irb):63:in `<main>`: Validation failed: Librarian name only allows letters (ActiveRecord::RecordInvalid)


# validates :librarian_name, format: { without: /\A[a-zA-Z]+\z/, message: "only allows numbers" }
Example:
3.3.0 :068 > a.librarian_name="Nishchay"
 => "Nishchay" 
3.3.0 :069 > a.save!
(irb):69:in `<main>`: Validation failed: Librarian name only allows numbers (ActiveRecord::RecordInvalid



5) inclusion ->
This helper validates that the attributes values are included in a given set. In fact, this set can be any enumerable object.

Example:
# validates :size, inclusion: { in: %w(small medium large),  message: "%{value} is not a valid size" }

3.3.0 :114 > a.size="full"
 => "full" 
3.3.0 :115 > a.save
 => false 
3.3.0 :116 > a.save!
(irb):116:in `<main>`: Validation failed: Size full is not a valid size (ActiveRecord::RecordInvalid)

3.3.0 :117 > a.size="medium"
 => "medium" 
3.3.0 :118 > a.save
  TRANSACTION (0.4ms)  BEGIN
  Librarian Update (3.1ms)  UPDATE "librarians" SET "updated_at" = $1, "status" = $2, "size" = $3 WHERE "librarians"."id" = $4  [["updated_at", "2024-07-22 11:53:25.271387"], ["status", "full"], ["size", "medium"], ["id", 16]]
  TRANSACTION (1.2ms)  COMMIT
 => true 



6) exclusion ->
The opposite of inclusion is... exclusion!

Example:
# validates :status, exclusion: { in: ["active", "inactive"] }
3.3.0 :121 > a.status="active"
 => "active" 
3.3.0 :122 > a.save!
(irb):122:in `<main>`: Validation failed: Status is reserved (ActiveRecord::RecordInvalid)



7) length ->
This helper validates the length of the attributes values.
We can customize these messages using the :wrong_length, :too_long, and :too_short options and %{count} as a placeholder for the number corresponding to the length constraint being used.

Example:
# validates :librarian_name, length: { maximum: 10 }
3.3.0 :132 > a.librarian_name= "NishchayGupta"
 => "NishchayGupta" 
3.3.0 :133 > a.save!
(irb):133:in `<main>`: Validation failed: Librarian name is too long (maximum is 10 characters) (ActiveRecord::RecordInvalid)


# validates :librarian_name, length: { is: 10 }
3.3.0 :145 > a.librarian_name= "Nishchay111"
 => "Nishchay111" 
3.3.0 :146 > a.save!
(irb):146:in `<main`: Validation failed: Librarian name is the wrong length (should be 10 characters) (ActiveRecord::RecordInvalid)


# validates :librarian_name, length: { minimum: 10 }
3.3.0 :136 > a.librarian_name= "NishchayGupta"
 => "NishchayGupta" 
3.3.0 :137 > a.save!
  TRANSACTION (0.4ms)  BEGIN
  Librarian Update (1.5ms)  UPDATE "librarians" SET "librarian_name" = $1, "updated_at" = $2 WHERE "librarians"."id" = $3  [["librarian_name", "NishchayGupta"], ["updated_at", "2024-07-22 12:15:18.399638"], ["id", 16]]
  TRANSACTION (2.0ms)  COMMIT
 => true 
3.3.0 :138 


# validates :librarian_name, length: { in: 10..20 }
3.3.0 :153 > a.librarian_name= "Nishchay"
 => "Nishchay" 
3.3.0 :154 > a.save!
(irb):154:in `<main>`: Validation failed: Librarian name is too short (minimum is 10 characters) (ActiveRecord::RecordInvalid)

3.3.0 :155 > a.librarian_name= "Nishchay111111111111111111"
 => "Nishchay111111111111111111" 
3.3.0 :156 > a.save!
(irb):156:in `<main>`: Validation failed: Librarian name is too long (maximum is 20 characters) (ActiveRecord::RecordInvalid)



8) numericality ->
This helper validates that your attributes have only numeric values. 
By default, it will match an optional sign followed by an integer or floating point number.
To specify that only integer numbers are allowed, set :only_integer to true. 
Then it will use the following regular expression to validate the attributes value.

Example:
# validates :phone_no, numericality: true
3.3.0 :171 > a.phone_no="hi"
 => "hi" 
3.3.0 :172 > a.save!
(irb):172:in `<main>`: Validation failed: Phone no is not a number (ActiveRecord::RecordInvalid)

# validates :phone_no, numericality: { only_integer: true }
3.3.0 :177 > a.phone_no="2.5"
 => "2.5" 
3.3.0 :178 > a.save!
(irb):178:in `<main>`: Validation failed: Phone no must be an integer (ActiveRecord::RecordInvalid)
3.3.0 :179 > a.phone_no="9588169118"
 => "9588169118" 
3.3.0 :180 > a.save!
  TRANSACTION (0.4ms)  BEGIN
  Librarian Update (2.9ms)  UPDATE "librarians" SET "phone_no" = $1, "updated_at" = $2 WHERE "librarians"."id" = $3  [["phone_no", "9588169118"], ["updated_at", "2024-07-23 06:28:33.560115"], ["id", 16]]
  TRANSACTION (0.5ms)  COMMIT
 => true 

# validates :phone_no, numericality: { odd: true }
3.3.0 :186 > a.phone_no="12"
 => "12" 
3.3.0 :187 > a.save!
(irb):187:in `<main>`: Validation failed: Phone no must be odd (ActiveRecord::RecordInvalid)

# validates :phone_no, numericality: { even: true }
3.3.0 :192 > a.phone_no="1"
 => "1" 
3.3.0 :193 > a.save!
(irb):193:in `<main>`: Validation failed: Phone no must be even (ActiveRecord::RecordInvalid)



9) presence ->
This helper validates that the specified attributes are not empty. 

Example:
# validates :librarian_name, presence: true
3.3.0 :196 > a.librarian_name=""
 => "" 
3.3.0 :197 > a.save!
(irb):197:in `<main>`: Validation failed: Librarian name cant be blank (ActiveRecord::RecordInvalid)

#  validates :librarian_name, presence: { message: 'must be present' }
3.3.0 :201 > a.librarian_name=""
 => "" 
3.3.0 :202 > a.save!
(irb):202:in `<main>`: Validation failed: Librarian name must be present (ActiveRecord::RecordInvalid)



10) absence ->
This helper validates that the specified attributes are absent.

Example:
#  validates :librarian_name, absence: true
3.3.0 :205 > a.librarian_name="nishu"
 => "nishu" 
3.3.0 :206 > a.save!
(irb):206:in `<main>`: Validation failed: Librarian name must be blank (ActiveRecord::RecordInvalid)



11) uniqueness ->
This helper validates that the attributes value is unique right before the object gets saved.

Example:
# validates :phone_no , uniqueness: true
3.3.0 :227 > a.phone_no=12
 => 12 
3.3.0 :228 > a.save!
  TRANSACTION (0.3ms)  BEGIN
  Librarian Exists? (1.0ms)  SELECT 1 AS one FROM "librarians" WHERE "librarians"."phone_no" = $1 AND "librarians"."id" != $2 LIMIT $3  [["phone_no", "12"], ["id", 14], ["LIMIT", 1]]
  TRANSACTION (0.2ms)  ROLLBACK
(irb):228:in `<main>`: Validation failed: Phone no has already been taken (ActiveRecord::RecordInvalid)



12) validates_each ->
This helper validates attributes against a block. 
It doesnt have a predefined validation function. 
You should create one using a block, and every attribute passed to validates_each will be tested against it.

Example:-
validates_each :librarian_name, :surname do |record, attr, value|
        record.errors.add(attr, 'must start with upper case') if /\A[[:lower:]]/.match?(value)
      end

3.3.0 :248 > a.surname = "gupta"
 => "gupta" 
3.3.0 :249 > a.save!
  TRANSACTION (0.3ms)  BEGIN
  Librarian Exists? (0.4ms)  SELECT 1 AS one FROM "librarians" WHERE "librarians"."phone_no" = $1 AND "librarians"."id" != $2 LIMIT $3  [["phone_no", "999999999"], ["id", 14], ["LIMIT", 1]]
  TRANSACTION (0.2ms)  ROLLBACK
(irb):249:in `<main>`: Validation failed: Surname must start with upper case (ActiveRecord::RecordInvalid)



13) validates_with ->
This helper passes the record to a separate class for validation.

Example:
class GoodnessValidator < ActiveModel::Validator
    def validate(record)
      if record.librarian_name == "Evil"
        record.errors.add :base, "This librarian is evil"
      end
    end
  end

3.3.0 :261 > a.librarian_name="Evil"
 => "Evil" 
3.3.0 :262 > a.save!
  TRANSACTION (0.4ms)  BEGIN
  Librarian Exists? (0.4ms)  SELECT 1 AS one FROM "librarians" WHERE "librarians"."phone_no" = $1 AND "librarians"."id" != $2 LIMIT $3  [["phone_no", "999999999"], ["id", 14], ["LIMIT", 1]]
  TRANSACTION (0.2ms)  ROLLBACK
(irb):262:in `<main>`: Validation failed: This librarian is evil (ActiveRecord::RecordInvalid)





===>    COMMON VALIDATION OPTIONS:-

1) :allow_nil -> Skip validation if the attribute is nil.

Example:
    VALID_GENRES = %w(fiction non-fiction fantasy mystery romance thriller)

    validates :genre_name, inclusion: { 
      in: VALID_GENRES, 
      message: "%{value} is not a valid genre" 
    }, allow_nil: true

3.3.0 :292 > genre.genre_name="Horror"
 => "Horror" 
3.3.0 :293 > genre.save
 => false 
3.3.0 :294 > genre.save!
(irb):294:in `<main>`: Validation failed: Genre name Horror is not a valid genre (ActiveRecord::RecordInvalid)

3.3.0 :295 > genre.genre_name=nil
 => nil 
3.3.0 :296 > genre.save!
  TRANSACTION (0.4ms)  BEGIN
  Genre Update (7.3ms)  UPDATE "genres" SET "genre_name" = $1, "updated_at" = $2 WHERE "genres"."id" = $3  [["genre_name", nil], ["updated_at", "2024-07-23 11:47:27.932684"], ["id", 1]]
  TRANSACTION (1.1ms)  COMMIT
 => true 


2) :allow_blank -> Skip validation if the attribute is blank. (allow both nil and " ")

Example:
 validates :genre_name, inclusion: { 
      in: VALID_GENRES, 
      message: "%{value} is not a valid genre" },
      allow_blank: true

3.3.0 :311 > genre.genre_name=""
 => "" 
3.3.0 :312 > genre.save!
  TRANSACTION (0.4ms)  BEGIN
  Genre Update (2.7ms)  UPDATE "genres" SET "genre_name" = $1, "updated_at" = $2 WHERE "genres"."id" = $3  [["genre_name", ""], ["updated_at", "2024-07-23 11:53:38.686617"], ["id", 1]]
  TRANSACTION (0.5ms)  COMMIT
 => true 


3) :message -> Specify a custom error message.

Example:
    validates :genre_name, presence: { message: "must be given please" }

3.3.0 :327 > genre.genre_name=""
 => "" 
3.3.0 :328 > genre.save!
(irb):328:in `<main>`: Validation failed: Genre name must be given please (ActiveRecord::RecordInvalid)


4) :on -> Specify the contexts where this validation is active.

Example:
    validates :genre_name, uniqueness: true, on: :create

3.3.0 :335 > genre = Genre.new(genre_name: "fantasy")
 => #<Genre:0x0000000121214888 id: nil, genre_name: "fantasy", created_at: nil, updated_at: nil> 
3.3.0 :336 > genre.save!
  TRANSACTION (0.4ms)  BEGIN
  Genre Exists? (1.3ms)  SELECT 1 AS one FROM "genres" WHERE "genres"."genre_name" = $1 LIMIT $2  [["genre_name", "fantasy"], ["LIMIT", 1]]
  TRANSACTION (0.2ms)  ROLLBACK
(irb):367:in `<main>`: Validation failed: Genre name has already been taken (ActiveRecord::RecordInvalid)



5) :strict          -> Raise an exception when the validation fails.

Example:
 validates :genre_name, presence: {strict: true}

3.3.0 :351 > genre.genre_name=""
 => "" 
3.3.0 :352 > genre.save!
  TRANSACTION (0.3ms)  BEGIN
  Genre Exists? (1.2ms)  SELECT 1 AS one FROM "genres" WHERE "genres"."genre_name" = $1 AND "genres"."id" != $2 LIMIT $3  [["genre_name", ""], ["id", 2], ["LIMIT", 1]]
  TRANSACTION (0.3ms)  ROLLBACK
(irb):352:in `<main>`: Genre name cant be blank (ActiveModel::StrictValidationFailed)




===>   CONDITIONAL VALIDATION

1) Using a Symbol with :if and :unless

Example:
   validates :isbn, presence: true, if: :book_present?
   def book_present?
     book_id.present?
   end

3.3.0 :435 > a = Transaction.new(member_id: 1, book_id: 1, issuedate: Date.today, returndate: Date.today + 14.days)
 => #<Transaction:0x0000000121a57450 id: nil, member_id: 1, isbn: nil, issuedate: Wed, 24 Jul 2024, returndate: Wed, 07 Aug 2024, created_at: nil, updated_at: nil, book_id: 1, librarian_id: nil> 
3.3.0 :436 > a.save!
(irb):436:in `<main>`: Validation failed: Isbn cant be blank (ActiveRecord::RecordInvalid)


2) Using a Proc with :if and :unless
Using a Proc object gives you the ability to write an inline condition instead of a separate method. This option is best suited for one-liners.

Example:
   validates :isbn, presence: true, unless: Proc.new { |t| t.issuedate.blank? }   # using proc
   validates :isbn, presence: true, unless: -> { issuedate.blank? }               # using lambda

3.3.0 :474 > transaction_without_date = Transaction.new(
3.3.0 :475 >   member_id: 1,
3.3.0 :476 >   isbn: "",
3.3.0 :477 >   issuedate: nil,
3.3.0 :478 >   returndate: Date.today + 14.days,
3.3.0 :479 >   book_id: 1,
3.3.0 :480 >   librarian_id: 17
3.3.0 :481 > )
3.3.0 :482 > 
3.3.0 :483 > puts transaction_without_date.valid?                  # Should return true even if ISBN is blank because issuedate is blank
3.3.0 :484 > puts transaction_without_date.errors.full_messages    # Should be empty if valid
true
 => nil 
3.3.0 :485 > transaction_without_date.save!
  TRANSACTION (0.4ms)  BEGIN
  Transaction Create (4.2ms)  INSERT INTO "transactions" ("member_id", "isbn", "issuedate", "returndate", "created_at", "updated_at", "book_id", "librarian_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING "id"  [["member_id", 1], ["isbn", ""], ["issuedate", nil], ["returndate", "2024-08-07"], ["created_at", "2024-07-24 06:25:24.075343"], ["updated_at", "2024-07-24 06:25:24.075343"], ["book_id", 1], ["librarian_id", 17]]
  TRANSACTION (0.4ms)  COMMIT
 => true 
3.3.0 :486


3) Grouping Conditional Validations

Example:
  def involves_special_member?
    member_id == 1
  end
  with_options if: :involves_special_member? do |transaction|
    transaction.validates :isbn, presence: true
    transaction.validates :book_id, presence: true
    transaction.validates :issuedate, presence: true
  end

3.3.0 :507 > transaction_special = Transaction.new(
3.3.0 :508 >   member_id: 1,
3.3.0 :509 >   isbn: nil,  
3.3.0 :510 >   issuedate: nil,  
3.3.0 :511 >   book_id: nil 
3.3.0 :512 > )
3.3.0 :515 > transaction_special.save!  
(irb):515:in `<main>`: Validation failed: Isbn cant be blank, Book cant be blank, Issuedate cant be blank (ActiveRecord::RecordInvalid)


4) Combining Validation Conditions

Example: (if id=1 & return date present then only validation applies )
 validates :isbn, :book_id, :issuedate, presence: true,
    if: -> { member_id == 1 },
    unless: -> { returndate.present? }

3.3.0 :537 > transaction = Transaction.new(
3.3.0 :538 >   member_id: 1,
3.3.0 :539 >   isbn: nil,
3.3.0 :540 >   issuedate: nil,
3.3.0 :541 >   book_id: nil
3.3.0 :542 > )
3.3.0 :543 > puts transaction.valid?  # Should be false
3.3.0 :544 > puts transaction.errors.full_messages
false
Isbn cant be blank
Book cant be blank
Issuedate cant be blank
 => nil 



===>  CUSTOM VALIDATIONS

1) Custom Validators -> 
Example:
class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless URI::MailTo::EMAIL_REGEXP.match?(value)
        record.errors.add attribute, (options[:message] || "is not an email")
      end
    end
  end

validates :email, presence: true, email: true

3.3.0 :554 > a.email = "inva@lid@1"
 => "inva@lid@1" 
3.3.0 :555 > a.save!
(irb):555:in `<main>`: Validation failed: Email is not an email (ActiveRecord::RecordInvalid)


2) Custom Methods -> 
Example:
   validate :check_author_name_format
    def check_author_name_format
      unless author_name.match?(/\A[A-Za-z]+\z/)
        errors.add(:author_name, "must only contain letters")
      end
    end

3.3.0 :556 > author_invalid = Author.new(author_name: "John123")
 => #<Author:0x00000001215d8640 id: nil, author_name: "John123", nationality: nil, created_at: nil, updated_at: nil> 
3.3.0 :557 > author_invalid.save!
(irb):557:in `<main>`: Validation failed: Author name must only contain letters (ActiveRecord::RecordInvalid)


3) Listing Validators ->
We can now use validators on the "Person" model to list all validators, or even check a specific field using validators_on.

Example:
3.3.0 :560 > Librarian.validators
 => 
[#<ActiveModel::Validations::ComparisonValidator:0x00000001215dd1b8 @attributes=[:number_of_books], @options={:greater_than=>0}>,
 #<ActiveModel::Validations::InclusionValidator:0x00000001215dc998 @attributes=[:status], @delimiter=["active", "inactive"], @options={:in=>["active", "inactive"]}>,
 #<ActiveModel::Validations::ExclusionValidator:0x00000001215dbc00 @attributes=[:subdomain], @delimiter=["www", "us", "ca", "jp"], @options={:in=>["www", "us", "ca", "jp"], :message=>"%{value} is reserved."}>,
 #<ActiveRecord::Validations::LengthValidator:0x00000001215db1d8 @attributes=[:librarian_name], @options={:minimum=>2, :maximum=>20}>,
 #<ActiveRecord::Validations::PresenceValidator:0x00000001215da080 @attributes=[:librarian_name], @options={}>,
 #<ActiveModel::BlockValidator:0x00000001215d96d0 @attributes=[:librarian_name, :surname], @block=#<Proc:0x00000001215d9680 /Users/nishchaygupta/Desktop/Training/Rails/library_management_system/app/models/librarian.rb:81>, @options={}>,
 #<ActiveRecord::Validations::NumericalityValidator:0x00000001215da620 @attributes=[:phone_no], @options={}>,
 #<ActiveRecord::Validations::UniquenessValidator:0x000000011ff4b5a8
  @attributes=[:phone_no],
  @klass=
   Librarian(id: integer, librarian_name: string, email: string, phone_no: string, address: string, created_at: datetime, updated_at: datetime, email_confirmation: string, number_of_books: integer, year_established: integer, library_code: string, max_capacity: integer, number_of_staff: integer, status: string, size: string, subdomain: string, surname: string),
  @options={}>,
 #<GoodnessValidator:0x00000001215d8988 @options={:on=>:update}>] 



====>   VALIDATION ERRORS

1) errors ->
The gateway through which you can drill down into various details of each error.
This returns an instance of the class ActiveModel::Errors containing all errors, each error is represented by an ActiveModel::Error object.

Example:
class Book < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
end

3.3.0 :561 > book = Book.new
 => #<Book:0x0000000120f338a8 id: nil, isbn: nil, title: nil, quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :562 > book.valid?
 => false 
3.3.0 :563 > book.errors.full_messages
 => ["Title can't be blank", "Title is too short (minimum is 5 characters)"] 

 
2) errors[] ->
It is used when you want to check the error messages for a specific attribute. 
It returns an array of strings with all error messages for the given attribute, each string with one error message. 
If there are no errors related to the attribute, it returns an empty array.

Example:
3.3.0 :568 > book.title="NG"
 => "NG" 
3.3.0 :569 > book.save!
(irb):569:in `<main>`: Validation failed: Title is too short (minimum is 5 characters) (ActiveRecord::RecordInvalid)
3.3.0 :570 > book.errors[:title]
 => ["is too short (minimum is 5 characters)"] 


3) errors.where and Error Object ->

Example:
3.3.0 :571 > book.errors.where(:title)
 => [#<ActiveModel::Error attribute=title, type=too_short, options={:count=>5}>] 

3.3.0 :578 > error = book.errors.where(:title).last
 => #<ActiveModel::Error attribute=title, type=too_short, options={:count=>5}> 
3.3.0 :579 > error.attribute
 => :title 
3.3.0 :580 > error.options[:count]
 => 5 
3.3.0 :581 > error.message
 => "is too short (minimum is 5 characters)" 
3.3.0 :582 > error.full_message
 => "Title is too short (minimum is 5 characters)" 


4) errors.add ->
The add method creates the error object by taking the attribute, the error type and additional options hash. 
This is useful when writing your own validator, as it lets you define very specific error situations.

Example:
    validate do |book|
        errors.add :title, :too_plain, message: "not cool enough"
    end

3.3.0 :585 > a=Book.create
 => #<Book:0x000000012117ae90 id: nil, isbn: nil, title: nil, quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :586 > a.errors.where(:title).first.type
 => :too_plain 
3.3.0 :587 > a.errors.where(:title).first.full_message
 => "Title not cool enough" 


5) errors[:base] ->
When you add an error to :base, it means the error is general and not related to any single attribute. 
For example, if the combination of several attributes is invalid, you would add an error to :base

Example:
    validate do |book|
        errors.add :base, :invalid, message: "This person is invalid because ..."
      end

3.3.0 :590 > a=Book.create
 => #<Book:0x0000000121535fa8 id: nil, isbn: nil, title: nil, quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :591 > a.errors.where(:base).first.full_message
 => "This person is invalid because ..." 


6) errors.size ->
The size method returns the total number of errors for the object.

Example:
    validates :title, presence: true, length: { minimum: 5 }

3.3.0 :593 > a = Book.create
 => #<Book:0x000000012101ade8 id: nil, isbn: nil, title: nil, quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :594 > a.errors.size
 => 2 

3.3.0 :599 > a = Book.new(title: "Nishchay")
 => #<Book:0x0000000121ed3d58 id: nil, isbn: nil, title: "Nishchay", quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :600 > a.valid?
 => true 
3.3.0 :601 > a.errors.size
 => 0 



7) errors.clear ->
The clear method is used when you intentionally want to clear the errors collection. 
Of course, calling errors.clear upon an invalid object wont actually make it valid: 
the errors collection will now be empty, but the next time you call valid? or any method that tries to save this object to the database, 
the validations will run again.If any of the validations fail, the errors collection will be filled again.

Example:

3.3.0 :603 > a = Book.create
 => #<Book:0x0000000120a73cf0 id: nil, isbn: nil, title: nil, quantity: nil, created_at: nil, updated_at: nil, available_quantity: nil, author_id: nil, genre_id: nil> 
3.3.0 :604 > a.valid?
 => false 
3.3.0 :605 > a.errors.empty?
 => false 
3.3.0 :606 > a.errors.clear
 => [] 
3.3.0 :607 > a.errors.empty?
 => true 
3.3.0 :608 > a.save
 => false 
3.3.0 :609 > a.errors.empty?
 => false 
3.3.0 :610 > 

