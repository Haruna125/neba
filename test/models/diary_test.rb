# == Schema Information
#
# Table name: diaries
#
#  id         :integer          not null, primary key
#  content    :text
#  image      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  adress     :string
#
require "test_helper"

class DiaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
