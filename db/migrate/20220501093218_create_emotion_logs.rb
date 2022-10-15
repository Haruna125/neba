class CreateEmotionLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :emotion_logs do |t|
      t.datetime :recorded_at, null: false, comment: '記録日時'
      t.string   :image_url, null: false, comment: '写真のURL'
      t.float    :happiness, null: false, default: 0,comment: '幸福度'
      t.float    :neutral, null: false, default: 0, comment: '平常度'
      t.float    :sadness, null: false, default: 0, comment: '哀しさ度'
      t.float    :surprise, null: false, default: 0, comment: '驚き度'
      t.float    :anger, null: false, default: 0, comment: '怒り度'
      t.float    :contempt, null: false, default: 0, comment: '軽蔑度'
      t.float    :disgust, null: false, default: 0, comment: '嫌悪度'
      t.float    :fear, null: false, default: 0, comment: '恐怖度'



      t.timestamps
    end
  end
end
