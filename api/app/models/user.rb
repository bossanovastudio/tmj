class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable
  # include DeviseTokenAuth::Concerns::User
  
  enum role: { user: 1, editor: 2, moderator: 3, admin: 4 }
  
  # Uploader
  mount_uploader :image, AvatarUploader
  
  has_many :cards
  has_many :providers
  recommends :cards
  
  def email_required?
    false
  end
end
