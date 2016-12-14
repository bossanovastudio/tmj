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
#

class Provider < ApplicationRecord
  belongs_to :user
  has_many :cards, foreign_key: 'social_uid', primary_key: 'uid'
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end
end
