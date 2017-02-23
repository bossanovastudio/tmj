# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string
#  keywords        :string
#  description     :string
#  content         :text
#  background_menu :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class PageTest < ActiveSupport::TestCase
  def page
    @page ||= Page.new
  end

  def test_valid
    assert page.valid?
  end
end
