class MembersController < ApplicationController

  # RESTful

  # リソースの一覧を表示
  def index
    @members = Member.order("number")
  end
  # リソースの詳細を表示(リソースの属性を表示)
  def show
    @member = Member.find(params[:id])
  end
  # リソースを新しく追加するためのフォームを表示
  def new
    @member = Member.new(1980, 1, 1) #引数に誕生日の初期値を指定
  end
  # リソースを新しく作成(テーブルに新しいレコードを作成する)
  def create
  end
  # 作成済みのリソースを更新するためのフォームを作成(既存のレコードのカラムを更新する)
  def edit
    @member = Member.find(params[:id])
  end
  # 作成済みのリソースを上書き（既存のレコードカラムを更新する）
  def update
  end
  # 作成済みのリソースを削除（テーブルからレコードを削除）
  def destroy
  end
  # リソースを検索するアクション
  def search
    @members = Member.search(params[:q]) #qには検索ワードが入ってくる
    render "index"
  end
end
