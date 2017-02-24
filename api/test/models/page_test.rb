# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  slug            :string
#  title           :string
#  keywords        :string
#  description     :string
#  content         :text
#  background_menu :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  background_page :string
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
