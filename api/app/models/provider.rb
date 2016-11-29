class Provider < ApplicationRecord
  belongs_to :user
  has_many :cards, foreign_key: 'social_uid', primary_key: 'uid'
end
