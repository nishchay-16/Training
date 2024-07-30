class Person < ApplicationRecord
  # include ActiveModel::AttributeMethods
  # attribute_method_prefix 'reset_'
  # attribute_method_suffix '_highest?'
  # define_attribute_method 'age'
  # attr_accessor :age
  # private
  #   def reset_attribute(attribute)
  #     send("#{attribute}=", 0)
  #   end
  #   def attribute_highest?(attribute)
  #     send(attribute) > 100
  #   end

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

  # include ActiveModel::Conversion
  # def persisted?
  #   false
  # end
  # def id
  #   nil
  # end

  # include ActiveModel::Dirty
  # define_attribute_method :name
  # def name
  #   @name
  # end
  # def name=(value)
  #   name_will_change!
  #   @name = value
  # end
  # def save
  #   # do save work...
  #   changes_applied
  # end

  # include ActiveModel::Validations
  # attr_accessor :name, :email
  # validates :name, presence: true
  # validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i

  # extend ActiveModel::Naming

  # include ActiveModel::Serialization
  # include ActiveModel::Serializers::JSON
  # attr_accessor :name
  # def attributes
  #   { 'name' => nil }
  # end

#it needs gem file bycrypt
  # include ActiveModel::SecurePassword
  # has_secure_password
  # has_secure_password :recovery_password, validations: false
  
end
