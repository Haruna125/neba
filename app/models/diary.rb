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
class Diary < ApplicationRecord
end
