# == Schema Information
#
# Table name: remix_categories
#
#  id         :integer          not null, primary key
#  cover      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class Remix::CategoryTest < ActiveSupport::TestCase
  def category
    @category ||= Remix::Category.new
  end

  def test_valid
    assert category.valid?
  end
end
