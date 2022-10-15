class DiariesController < ApplicationController
  #管理対象の「Diary」の一覧を表示する
  def index
    #新しい投稿６個を順に表示する（creatrd_atは作成された日時）
    @diaries = Diary.order(creatrd_at: :desc).limit(5)
  end

  # 管理対象の「Diary」を新規登録する画面を返すアクション（ルーティングに対応する処理の受け口になるメソッド）。
  def new
    @diary = Diary.new
  end

  # 管理対象の「Diary」を新しく作って永続化するアクション。
  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      #保存できた場合show画面に遷移する
      redirect_to :action => "index"
    else
      #保存できなかった場合new画面に遷移する
      redirect_to :action => "new"
    end
  end

  #「Diary」内の検索したいidを取得して表示する
  def show
    @diary= Diary.find(params[:id])
  end

  # idに該当するdiaryを取得し編集画面を返す
  def edit
    @diary = Diary.find(params[:id])
  end

  # idに該当するdiaryを取得し更新する
  def update
    diary = Diary.find(params[:id])
    if diary.update(diary_params)
      #管理対象の「Diary」のidが更新できたら show画面に遷移する
      redirect_to :action =>"show", :id =>diary.id
    else
      #管理対象の「Diary」のidが更新できなかったら new画面に遷移する
      redirect_to :action =>"new"
    end
  end

  # 管理対象の「Diary」のidを取得し削除するアクション
  def destroy
    diary = diary.find(params[:id])
    diary.destroy
    redirect_to action: :index
  end

  #以下のメソッドはDiariesControllerクラス内のみで実行出来る
  private

  #diary_paramsメソッドを定義
  def diary_params

    #paramsから取得するデータのオブジェクト名diaryのtitle, contentのキーを指定する
    params.require(:diary).permit(:title, :content)
  end
end
