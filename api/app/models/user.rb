# == Schema Information
#
# Table name: users
#
#  id                                    :integer          not null, primary key
#  encrypted_password                    :string           default(""), not null
#  reset_password_token                  :string
#  reset_password_sent_at                :datetime
#  remember_created_at                   :datetime
#  sign_in_count                         :integer          default(0), not null
#  current_sign_in_at                    :datetime
#  last_sign_in_at                       :datetime
#  current_sign_in_ip                    :string
#  last_sign_in_ip                       :string
#  confirmation_token                    :string
#  confirmed_at                          :datetime
#  confirmation_sent_at                  :datetime
#  unconfirmed_email                     :string
#  image                                 :string
#  email                                 :string
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  username                              :string           not null
#  role                                  :integer          default("user")
#  mask                                  :string
#  authentication_token                  :string(30)
#  bio                                   :text
#  editor_color                          :string
#  editor_icon                           :string
#  editor_desktop_background             :string
#  editor_mobile_background              :string
#  editor_menu_background                :string
#  editor_recommendation_ribbon          :string
#  editor_avatar_hover                   :string
#  editor_recommendation_ribbon_animated :string
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable, :recoverable

  enum role: { user: 1, editor: 2, moderator: 3, admin: 4 }
  scope :editors, -> { where(role: :editor) }
  scope :regular, -> { where(role: :user) }

  # Uploader
  mount_uploader :image, AvatarUploader
  mount_uploader :mask, MaskUploader
  mount_uploader :editor_icon, EditorAssetUploader
  mount_uploader :editor_desktop_background, EditorAssetUploader
  mount_uploader :editor_mobile_background, EditorAssetUploader
  mount_uploader :editor_menu_background, EditorAssetUploader
  mount_uploader :editor_recommendation_ribbon, EditorAssetUploader
  mount_uploader :editor_recommendation_ribbon_animated, EditorAssetUploader
  mount_uploader :editor_avatar_hover, EditorAssetUploader

  has_many :providers
  has_many :cards, through: :providers
  has_many :editor_networks
  recommends :cards
  acts_as_followable
  acts_as_follower

  after_create :send_welcome_email

  # Validations
  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-zA-Z\.\-\_]+\z/ }, length: { in: 4..16 }

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

  def editor_network_url(k)
    n = self.editor_networks.find_by(kind: k)
    n.url unless n.nil?
  end

  private
    def send_welcome_email
      return true unless email
      UsersMailer.welcome(self).deliver_now
    end
end
