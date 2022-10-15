# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


   belongs_to :user
   has_attached_file :file, default_url: "missing.jpg"

   def face_detection
  Curl.post("https://api.projectoxford.ai/face/v1.0/detect", "{ url: '#{self.file.url}' }" ) do |curl|
   curl.headers["Ocp-Apim-Subscription-Key"] = Rails.application.secrets.microsoft['face_api_key']
   curl.headers["Content-Type"] = 'application/json'
     end
    end
  end






