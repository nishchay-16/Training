class Person < ApplicationRecord
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

    include ActiveModel::Validations
  
    attr_accessor :name, :email
  
    validates :name, presence: true
    validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
  
end
