# == Schema Information
#
# Table name: emotion_logs
#
#  id          :integer          not null, primary key
#  recorded_at :datetime         not null
#  image_url   :string           not null
#  happiness   :float            not null
#  neutral     :float            not null
#  sadness     :float            not null
#  surprise    :float            not null
#  anger       :float            not null
#  contempt    :float            not null
#  disgust     :float            not null
#  fear        :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EmotionLog < ApplicationRecord
end
