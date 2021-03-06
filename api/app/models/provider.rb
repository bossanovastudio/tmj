# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string
#

class Provider < ApplicationRecord
  belongs_to :user
  has_many :cards, foreign_key: 'social_uid', primary_key: 'uid'
  
  def self.create_with_omniauth(auth)
    create(uid: auth.uid, provider: auth.provider, username: (auth.info.nickname || auth.uid))
  end
    
  def self.find_with_omniauth(auth)
     find_by(uid: auth.uid, provider: auth.provider)
  end
end
