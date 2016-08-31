class Video < ApplicationRecord
  enum origin: { youtube: 1, vimeo: 2 }
end
