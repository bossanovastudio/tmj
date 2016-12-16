# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  image                  :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string           not null
#  role                   :integer          default("user")
#  mask                   :string
#  authentication_token   :string(30)
#  bio                    :text
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable, :recoverable

  enum role: { user: 1, editor: 2, moderator: 3, admin: 4 }
  scope :editors, -> { where(role: :editor) }
  scope :regular, -> { where(role: :user) }

  # Uploader
  mount_uploader :image, AvatarUploader
  mount_uploader :mask, MaskUploader

  has_many :providers
  has_many :cards, through: :providers
  recommends :cards, :users

  after_create :send_welcome_email
  
  # Validations
  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-zA-Z]+\z/ }, length: { in: 6..16 }

  def update_without_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def password_required?
    true
  end
  
  private  
    def send_welcome_email
      return true unless email
      UsersMailer.welcome(self).deliver_now
    end
end
