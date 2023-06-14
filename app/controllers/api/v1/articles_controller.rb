module Api::V1
 class ArticlesController < BaseApiController #Api::V1::BaseApiController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

   def index
     @articles = Article.published.order(updated_at: :desc)
     render json: @articles, each_serializer: Api::V1::ArticlePreviewSerializer
   end

   def show
     article = Article.published.find(params[:id])
     render json: article, serializer: Api::V1::ArticleSerializer
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
