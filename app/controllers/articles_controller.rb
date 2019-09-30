class ArticlesController < ApplicationController
  before_action :login_required, except: [:index, :show] #indexとshow以外はメンバーとしてログインしていることがアクセスの条件

  #記事一覧
  def index
    @articles = Article.order(released_at: :desc)

    @articles = @articles.open_to_the_public unless current_member #ユーザーがログインしてかつ管理者である時にTrueを返す

    unless current_member&.administrator?
      @articles = @articles.visible
    end

    @articles = @articles.page(params[:page]).per(5) #ページネーション 5行
  end
  #記事の詳細
  def show
    articles = Article.all

    articles = articles.open_to_the_public unless current_member #ユーザーがログインしてかつ管理者である時にTrueを返す

    unless current_member&.administrator?
      articles = articles.visible
    end

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
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "ニュース記事を登録しました"
    else
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
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

  # ストロングパラメータ
  private def article_params
    params.require(:article).permit(
      :title,:body,:released_at,:no_expiration,:expired_at,:member_only
    )
  end
end
