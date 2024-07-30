                                                 ====> ACTIVE MODEL <=====

Active Model is a library containing various modules used in developing classes that need some features present on Active Record.

1) API -> ActiveModel::API adds the ability for a class to work with Action Pack and Action View right out of the box.
    Example:
      class EmailContact
        include ActiveModel::API
      
        attr_accessor :name, :email, :message
        validates :name, :email, :message, presence: true
      
        def deliver
          if valid?
            # deliver email
          end
        end
      end

    3.3.0 :245 > email_contact = EmailContact.new(name: 'David', email: 'david@example.com', message: 'Hello World')
      => #<EmailContact:0x000000012e5fcda8 id: nil, name: nil, email: nil, message: nil, created_at: nil, updated_at: nil> 
    3.3.0 :246 >  email_contact.name
      => "David" 
    3.3.0 :247 > email_contact.email
      => "david@example.com" 
    3.3.0 :248 > email_contact.valid?
    3.3.0 :249 > 
      => true 
    3.3.0 :250 > email_contact.persisted?
      => false 
     

2) Attribute Methods -> The ActiveModel::AttributeMethods module can add custom prefixes and suffixes on methods of a class. 
                        It is used by defining the prefixes and suffixes and which methods on the object will use them.


3) Callbacks -> ActiveModel::Callbacks gives Active Record style callbacks.
                This provides an ability to define callbacks which run at appropriate times.
                After defining callbacks, you can wrap them with before, after, and around custom methods.


4) Conversion ->  If a class defines persisted? and id methods, then you can include the ActiveModel::Conversion module in that class,
                  and call the Rails conversion methods on objects of that class.
    Example:
    class Person
      include ActiveModel::Conversion
    
      def persisted?
        false
      end
    
      def id
        nil
      end
    end

    3.3.0 :252 > person = Person.new
    3.3.0 :253 > 
     => #<Person:0x000000012e3d6178 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil> 
    3.3.0 :254 > person.to_model == person
     => true 
    3.3.0 :255 > person.to_key
    3.3.0 :256 > 
     => nil 
    3.3.0 :257 > person.to_param
     => nil 


5) Dirty -> An object becomes dirty when it has gone through one or more changes to its attributes and has not been saved. 
            ActiveModel::Dirty gives the ability to check whether an object has been changed or not. 
            It also has attribute-based accessor methods.


6) Validations -> The ActiveModel::Validations module adds the ability to validate objects like in Active Record.
    Example:
      class Person
        include ActiveModel::Validations
      
        attr_accessor :name, :email
      
        validates :name, presence: true
        validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
      end

     3.3.0 :293 > person = Person.new
      => #<Person:0x000000012e91c560 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil> 
     3.3.0 :294 > person.valid?
      => false 
     3.3.0 :295 > person.name = 'vishnu'
      => "vishnu" 
     3.3.0 :296 > person.email = 'me'
      => "me" 
     3.3.0 :297 > person.valid?
      => false 
     3.3.0 :298 > person.email = 'me@vishnuatrai.com'
      => "me@vishnuatrai.com" 
     3.3.0 :299 > person.valid?
      => true 
