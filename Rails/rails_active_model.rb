                                                =====> ACTIVE MODEL <=====
Active Model allows you to create plain Ruby objects that integrate with Action Pack, but dont need Active Record for database persistence. 
Active Model also helps build custom ORMs for use outside of the Rails framework. 
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
      Example:
        class Person
          include ActiveModel::AttributeMethods
        
          attribute_method_prefix 'reset_'
          attribute_method_suffix '_highest?'
          define_attribute_methods 'age'
        
          attr_accessor :age
        
          private
            def reset_attribute(attribute)
              send("#{attribute}=", 0)
            end
        
            def attribute_highest?(attribute)
              send(attribute) > 100
            end
        end
        
       3.3.0 :327 > person = Person.new
        => #<Person:0x000000012ecf1b90 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil, password_digest: nil, recovery_password_digest: nil> 
       3.3.0 :328 > person.age = 105
        => 105 
       3.3.0 :329 > person.age_highest?
       3.3.0 :330 > 
        => true 
       3.3.0 :331 > person.reset_age
        => 0 
       3.3.0 :332 > person.age_highest?
        => false 


3) Callbacks -> ActiveModel::Callbacks gives Active Record style callbacks.
                This provides an ability to define callbacks which run at appropriate times.
                After defining callbacks, you can wrap them with before, after, and around custom methods.
      Example:
      class Person
        extend ActiveModel::Callbacks
      
        define_model_callbacks :update
      
        before_update :reset_me
      
        def update
          run_callbacks(:update) do
            puts "Updating the person..."
          end
        end

        def reset_me
          puts "Resetting before update..."
        end
      end

      3.3.0 :334 > person = Person.new
      3.3.0 :335 > 
       => #<Person:0x000000012e4f9c08 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil, password_digest: nil, recovery_password_digest: nil> 
      3.3.0 :336 > person.update
      Resetting before update...
      Updating the person...
       => nil 


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


7) Naming ->  ActiveModel::Naming adds several class methods which make naming and routing easier to manage. 
              The module defines the model_name class method which will define several accessors using some ActiveSupport::Inflector methods.
    Example:
      class Person
        include ActiveModel::Naming
      end

     3.3.0 :301 > Person.model_name.name
      => "Person" 
     3.3.0 :302 > Person.model_name.singular
      => "person" 
     3.3.0 :303 > Person.model_name.plural
      => "people" 
     3.3.0 :304 > Person.model_name.element
      => "person" 
     3.3.0 :305 > Person.model_name.human
      => "Person" 
     3.3.0 :306 > Person.model_name.collection
      => "people" 
     3.3.0 :307 > Person.model_name.param_key
      => "person" 
     3.3.0 :308 > Person.model_name.i18n_key
      => :person 
     3.3.0 :309 > Person.model_name.route_key
      => "people" 
     3.3.0 :310 > Person.model_name.singular_route_key
      => "person" 


8) Model -> ActiveModel::Model allows implementing models similar to ActiveRecord::Base.
            When including ActiveModel::Model we get all the features from ActiveModel::API.


9) Serialization -> ActiveModel::Serialization provides basic serialization for your object. 
                    You need to declare an attributes Hash which contains the attributes you want to serialize. 
                    Attributes must be strings, not symbols.
      Example:
    * class Person
        include ActiveModel::Serialization
      
        attr_accessor :name
      
        def attributes
          { 'name' => nil }
        end
      end

     3.3.0 :312 > person = Person.new
      => #<Person:0x000000012e4b2380 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil> 
     3.3.0 :313 > person.serializable_hash
      => {"id"=>nil, "name"=>nil, "email"=>nil, "age"=>nil, "created_at"=>nil, "updated_at"=>nil} 
     3.3.0 :314 > person.name = "Nishhh"
      => "Nishhh" 
     3.3.0 :315 > person.serializable_hash
      => {"id"=>nil, "name"=>"Nishhh", "email"=>nil, "age"=>nil, "created_at"=>nil, "updated_at"=>nil} 

    * class Person
        include ActiveModel::Serializers::JSON
      
        attr_accessor :name
      
        def attributes
          { 'name' => nil }
        end
      end

     3.3.0 :317 > person = Person.new
      => #<Person:0x000000012e4db190 id: nil, name: nil, email: nil, age: nil, created_at: nil, updated_at: nil> 
     3.3.0 :318 > person.as_json
      => {"id"=>nil, "name"=>nil, "email"=>nil, "age"=>nil, "created_at"=>nil, "updated_at"=>nil} 
     3.3.0 :319 > person.name = "vaibhav"
      => "vaibhav" 
     3.3.0 :320 > person.as_json
      => {"id"=>nil, "name"=>"vaibhav", "email"=>nil, "age"=>nil, "created_at"=>nil, "updated_at"=>nil} 


10) Translation -> ActiveModel::Translation provides integration between your object and the Rails internationalization (i18n) framework.
11) Lint Tests -> ActiveModel::Lint::Tests allows you to test whether an object is compliant with the Active Model API.
12) SecurePassword -> ActiveModel::SecurePassword provides a way to securely store any password in an encrypted form. 
                      When you include this module, a has_secure_password class method is provided which defines a password accessor with certain validations on it by default.
                      It needs gem file bycrypt.



