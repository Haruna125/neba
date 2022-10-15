# 「EmotionLog」に関するリクエストを受け付けるコントローラのクラス定義
class EmotionLogsController < ApplicationController
  # 管理対象の「EmotionLog」を新規登録する画面を返すアクション（ルーティングに対応する処理の受け口になるメソッド）。
  def new
    # 新規登録画面で使用する「EnotionLog」のインスタンス（モデルクラスの実体）を生成する。
    @emotion_log = EmotionLog.new
  end

  # 管理対象の「EmotionLog」を詳細情報を見せる画面を返すアクション。
  def show
  end

  # 管理対象の「EmotionLog」を新しく作って永続化するアクション。
  def create
    @emotion_log = EmotionLog.new(emotion_log_params)

    #POST {Endpoint}/face/v1.0/detect?returnFaceId={returnFaceId}&returnFaceLandmarks={returnFaceLandmarks}&returnFaceAttributes={returnFaceAttributes}&recognitionModel={recognitionModel}&returnRecognitionModel={returnRecognitionModel}&detectionModel={detectionModel}&faceIdTimeToLive={faceIdTimeToLive}
    #アクセスしたいURLを書く
    uri = URI.parse("https://20010214.cognitiveservices.azure.com/face/v1.0/detect")
    #HTTPの設定
    http = Net::HTTP.new(uri.host, 443)
    #httpsを使うかどうか
    http.use_ssl = true
    #httpsを使う場合
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #実際に送るリクエストボディーの設定
    message = "{\"url\":\"https://upload.wikimedia.org/wikipedia/commons/c/c3/RH_Louise_Lillian_Gish.jpg\"}"

    #microsoftのAPIに投げるための画像データを取得する
    response = http.start do
      #リクエストを投げる
      req = Net::HTTP::Post.new(uri.path)
      req.add_field('Ocp-Apim-Subscription-Key', '003383e0b0d2445f92a3b87d59a15a23')
      req.add_field('Content-Type', 'application/json')
      #リクエストボディの設定
      req.body = message
      #リクエストを送る 解析された結果がresponseに入る
      http.request(req)
    end
    @result = JSON.parse(response.body)
    Rails.logger.info(self) { "レスポンス: #{@result}" }

    # TODO: @result から各感情分析結果を取り出す
    # TODO: 取り出した感情分析結果でemotion_logに値を詰める

    # curl \
    #   -H "Ocp-Apim-Subscription-Key: 003383e0b0d2445f92a3b87d59a15a23" \
    #   "https://20010214.cognitiveservices.azure.com/face/v1.0/detect?detectionModel=detection_01&returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion"\
    #   -H "Content-Type: application/json"\
    #   --data-ascii "{\"url\":\"https://upload.wikimedia.org/wikipedia/commons/c/c3/RH_Louise_Lillian_Gish.jpg\"}"

    #p→ログに出すメソッド inspect→オブジェクトの中身を加工
    #p @result.inspect
    #@id = @result[0]["id"]
    #@name = @result[0]["name"]
    #@email = @result[0]["email"]
    #@zipcode = @result[0]["zipcode"]
    #@county = @result[0]["county"]

    # 永続化対象の「EmotionLog」のインスタンスの記録日時に現在日時を代入する。
    @emotion_log.recorded_at = Time.zone.now
   #永続化対象の「EmotionLog」のインスタンスの幸福度に初期値として 0 を代入する。
   @emotion_log.anger = 0.03 #@result[0]['faceAttributes']['emotion']['anger']
   @emotion_log.happiness = 0.01 #@result[0]['faceAttributes']['emotion']['hapiness']
   @emotion_log.neutral = 0.0 #@result[0]['faceAttributes']['emotion']['neutral']
   @emotion_log.surprise = 0.0 #@result[0]['faceAttributes']['emotion']['surprise']
   @emotion_log.sadness = 0.05 #@result[0]['faceAttributes']['emotion']['sadness']
   @emotion_log.contempt = 0.08 #@result[0]['faceAttributes']['emotion']['contempt']
   @emotion_log.disgust = 0.02 #@result[0]['faceAttributes']['emotion']['disgust']
   @emotion_log.fear = 0.03 #@result[0]['faceAttributes']['emotion']['fear']


    #保存対象の「EmotionLog」を条件分岐する
    if @emotion_log.save
      #保存できた場合show画面に遷移する
      redirect_to emotion_log_path(@emotion_log)
    else
      #保存できなかった場合new画面に遷移する
      redirect_to :action => "new"
    end
  end

   def index
    @emotion_logs = EmotionLog.all
   end

  def show
    #「EmotionLog」内の検索したいidを取得して表示する
    @emotion_log = EmotionLog.find(params[:id])
  end

  def emotion_log_params

    params
      #emotion_logモデルのパラメータ群を受け取る
      .require(:emotion_log)
      #利用可能なパラメータ名image_urlを指定
      .permit(:image_url)
  end
end

#1 ストロングパラメータと１５行目の記述
#2 33行目のボディで設定 ←メッセージという変数の中身にURLの入ったJsonを入れる
#３ 21行目
#4  35行目
#5  39行目


