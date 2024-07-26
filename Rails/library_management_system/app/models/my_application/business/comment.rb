module MyApplication
  module Business
    class Comment < ApplicationRecord
      belongs_to :commentable, polymorphic: true
    end
  end
end
