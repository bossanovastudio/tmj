# == Schema Information
#
# Table name: editor_networks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  kind       :integer
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EditorNetwork < ApplicationRecord
  belongs_to :user
  enum kind: [:pinterest, :facebook, :instagram, :tumblr, :vimeo, :twitter, :google, :youtube, :twitch]
end
