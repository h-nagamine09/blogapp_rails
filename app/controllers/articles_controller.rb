class ArticlesController < ApplicationController
  before_action :login_required, exept: [:index, :show] #indexとshow以外はメンバーとしてログインしていることがアクセスの条件

  #記事一覧
  def index
    @articles = Article.order(released_at: :desc)
  end
  #記事の詳細
  def show
    @article = Article.find(params[:id])
  end
  #新規登録フォーム
  def new
    @article = Article.new
  end
 #編集フォーム
  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: "ニュース記事を登録しました"
    else
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(params[:article])
    if @article.save
      redirect_to @article, notice: "ニュース記事を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles
  end
end
