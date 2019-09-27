class EntriesController < ApplicationController
  before_action :login_required, except: [:index, :show]

  #記事一覧
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member)
      .order(posted_at: :desc).page(params[:page]).per(3)
  end
  #記事詳細
  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end
  #新規登録フォーム
  def new
    @entry = Entry.new(posted_at: Time.current) #デフォルトの投稿日時を現在の日時にしている
  end
  #新規作成 createアクションが実質の新規作成機能を担う
  def create
    @entry = Entry.new(params[:entry])
    @entry.author = current_member #現在ログインしているユーザーを記事の筆者にする
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました"
    else
      render "new"
    end
  end
 #編集フォーム
  def edit
    @entry = current_member.entries.find(params[:id])
  end
 # 更新
  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(params[:entry])
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました"
    else
      render "edit"
    end
  end
 #削除機能
  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: "記事を削除しました"
  end
end
