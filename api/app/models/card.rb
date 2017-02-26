# == Schema Information
#
# Table name: cards
#
#  id                  :integer          not null, primary key
#  origin              :integer
#  content             :text
#  media_type          :string
#  media_id            :integer
#  posted_at           :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  source_url          :string
#  status              :integer          default("pending")
#  size                :integer          default("one")
#  social_user         :json
#  social_uid          :string
#  remix_image_id      :integer
#  moderation_metadata :json
#

class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5, pinterest: 6, tumblr: 7 }
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  enum status: { pending: 1, accepted: 2, rejected: 3 }
  belongs_to :media, polymorphic: true
  belongs_to :provider, foreign_key: 'social_uid', primary_key: 'uid'
  has_one :user, through: :provider
  belongs_to :remix_image, class_name: "Remix::UserImage"

  ##### About moderation_metadata #####
  # Assume the following structure for the json field:
  # {
  #   home: true,
  #   madebyyou: true,
  #   characters: {
  #     ramona: true
  #   }
  # }
  # *Never* assume that a key is present, always test the key presence
  # before attempting casts.
  # *Always* assume an absent key as `false`.
  # The `characters` key is dynamic. If a card has not been moderated, the
  # key will be absent. In case a card has been reject, the key have `false`
  # as its value. Otherwise, the card has been moderated and approved, thus
  # the key value will be `true`.
  #
  # The migration responsible for moving current data to the new structure
  # will basically take all approved cards and set the metadata to `home: true`.
  # No further changes or assumptions will be made by the migration, and
  # characters-specific data will have to be moderated once again.
  # - Vito

  # TODO: deprecate
  scope :ordered, -> { order(posted_at: 'DESC') }
  scope :approved, -> { where(status: :accepted) }
  scope :not_rejected, -> { where.not(status: :rejected) }

  scope :for_home, -> { where("moderation_metadata::jsonb ? 'home' AND (moderation_metadata::jsonb #> '{home}')::text::boolean") }
  scope :for_madebyyou, -> { where("moderation_metadata::jsonb ? 'madebyyou' AND (moderation_metadata::jsonb #> '{madebyyou}')::text::boolean") }
  scope :for_editor, -> username { where("(moderation_metadata::jsonb ? 'characters') AND ((moderation_metadata::jsonb #> '{characters}')::jsonb ? '#{username}') AND ((moderation_metadata::jsonb #> '{characters,#{username}}')::text::boolean)") }

  # This next was intended to be a scope, but the complexity of it made
  # the scope body fugly.
  def self.with_status(status, *relative_to)
    status = status.downcase.to_sym
    relative_to = [relative_to] unless relative_to.kind_of? Array
    expr = nil
    if status == :pending
      # Pending express a lack of the the relative_to in the moderation
      # structure
      expr = "moderation_metadata::jsonb #> '{#{relative_to.join(',')}}' IS NULL"
    elsif status == :accepted || status == :rejected
      expr = "(moderation_metadata::jsonb #> '{#{relative_to.join(',')}}')::text::boolean"
      expr = "not #{expr}" if status == :rejected
    else
      return all
    end

    return self.where(expr)
  end

  def self.filter_query(params)
    options = {}
    if params.present?
      params.each do |field|
        options[field] = params[field] unless params[field].empty?
      end
    end
    if options.present?
      left_joins(:provider).where(options)
    else
       all  ## or nil if you don't want to show any records in view
    end
  end

  def kind
    if media_type == 'Image'
      :image
    elsif media_type == 'Video'
      :video
    else
      :text
    end
  end

  def is_from_remix?
    !remix_image.nil?
  end

  def first_recommended_by
    self.liked_by.where(role: :editor).first
  end

  def recommended_by_editor?
    !first_recommended_by.nil?
  end

  def moderate_for_editor(name, approved)
    mod = self.moderation_metadata || {}
    chars = mod.fetch(:characters, {})
    chars[name.to_sym] = approved
    mod[:characters] = chars
    self.moderation_metadata = mod
  end

  def moderate_for_home(approved)
    mod = self.moderation_metadata || {}
    mod[:home] = approved
    self.moderation_metadata = mod
  end

  def moderate_for_madebyyou(approved)
    mod = self.moderation_metadata || {}
    mod[:madebyyou] = approved
    self.moderation_metadata = mod
  end

  def relative_status(relative_to)
    meta = self.moderation_metadata || {}
    value = nil
    if relative_to == :home || relative_to == :madebyyou
      value = meta.fetch(relative_to.to_s, nil)
    else
      value = meta.fetch("characters", {}).fetch(relative_to.to_s, nil)
    end
    return 'pending' if value.nil?
    return 'rejected' if !value
    return 'accepted'
  end
end
