class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  
  enum role: { user: 1, editor: 2, moderator: 3, admin: 4 }
  
  has_many :cards
  recommends :cards
end
