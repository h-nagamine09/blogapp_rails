class MembersController < ApplicationController
  before_action :login_required

  # RESTful

  # リソースの一覧を表示
  def index
    @members = Member.order("number")
    .page(params[:page]).per(15) #ページネーション 15行
  end

  # リソースを検索するアクション
  def search
    @members = Member.search(params[:q]) #qには検索ワードが入ってくる
    .page(params[:page]).per(15)
    render "index"    
  end

  # リソースの詳細を表示(リソースの属性を表示)
  def show
    @member = Member.find(params[:id])
  end

  # リソースを新しく追加するためのフォームを表示
  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1)) #引数に誕生日の初期値を指定
  end

  # リソースを新しく作成(テーブルに新しいレコードを作成する)
  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to @member, notice: "会員を登録しました"
    else
      render "new"
    end
  end

  # 作成済みのリソースを更新するためのフォームを作成(既存のレコードのカラムを更新する)
  def edit
    @member = Member.find(params[:id])
  end

  # 作成済みのリソースを上書き（既存のレコードカラムを更新する）
  def update
    @member = Member.find(params[:id]) #メンバーの値をDBから取得
    @member.assign_attributes(params[:member]) #フォームからのデータをセット
    if @member.save
      redirect_to @member, notice: "会員情報を更新しました" #saveが成功するとTrueを返しDBを更新、noticeを表示
    else
      render "edit" #saveに失敗した場合edit画面を表示する
    end
  end

  # 作成済みのリソースを削除（テーブルからレコードを削除）
  def destroy
    @member = Member.find(params[:id]) #DBから会員情報を取得
    @member.destroy #destroyメソッドで取得したデータを削除
    redirect_to :members, notice: "会員を削除しました" #メンバー一覧ページにリダイレクト。noticeを表示させる
  end
end
