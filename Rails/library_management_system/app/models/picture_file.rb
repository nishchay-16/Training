class PictureFile < ApplicationRecord
  after_destroy FileDestroyerCallback.new
end
