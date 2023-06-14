module Api::V1
 class ArticlesController < BaseApiController #Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

   def index
    @published_articles = Article.published.order(updated_at: :desc)
    @draft_articles = current_user.articles.draft.order(updated_at: :desc)
    @articles = @published_articles + @draft_articles
     render json: @articles, each_serializer: Api::V1::ArticlePreviewSerializer
   end

   def show
    @article = Article.find(params[:id])
    if @article.published? || @article.user == current_user
      render json: @article, serializer: Api::V1::ArticleSerializer
    else
      render json: { errors: 'Not found' }, status: :not_found
    end
   end

   def create
     @article = current_user.articles.create!(article_params)
     #@article.toggle_status! #下書き状態であれば公開状態に、公開状態であれば下書き状態に切り替え
     render json: @article, serializer: Api::V1::ArticleSerializer
   end

   def update
     # 対象のレコードを探す
     article = current_user.articles.find(params[:id])
     # 探してきたレコードに対して変更を行う
     article.update!(article_params)
     #article.toggle_status! #下書き状態であれば公開状態に、公開状態であれば下書き状態に切り替え
     render json: article, serializer: Api::V1::ArticleSerializer
   end

   def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
   end

   private

   def article_params
     params.require(:article).permit(:title, :body, :status)
   end
 end
end

  #  def drafts
  #   @draft_articles = current_user.articles.draft.order(updated_at: :desc)
  #   render json: @draft_articles, each_serializer: Api::V1::ArticlePreviewSerializer
  #  end

  #  def draft
  #    @article = Article.find(params[:id])
  #    if @article.user == current_user
  #      if @article.draft?
  #        render json: @article, serializer: Api::V1::ArticleSerializer
  #      else
  #        update_as_draft
  #      end
  #    else
  #     render json: { errors: 'Not found' }, status: :not_found
  #    end
  #  end
