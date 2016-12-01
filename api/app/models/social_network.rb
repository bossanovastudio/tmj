# == Schema Information
#
# Table name: social_networks
#
#  id         :integer          not null, primary key
#  name       :string
#  origin     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SocialNetwork < ApplicationRecord
end
