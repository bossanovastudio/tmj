# == Schema Information
#
# Table name: remix_patterns
#
#  id         :integer          not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class Remix::PatternTest < ActiveSupport::TestCase
  def pattern
    @pattern ||= Remix::Pattern.new
  end

  def test_valid
    assert pattern.valid?
  end
end
