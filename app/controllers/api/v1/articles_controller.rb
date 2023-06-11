module Api::V1
 class ArticlesController < BaseApiController #Api::V1::BaseApiController
   def index
     @articles = Article.order(updated_at: :desc)
     render json: @articles, each_serializer: Api::V1::ArticlePreviewSerializer
   end

   def show
     article = Article.find(params[:id])
     render json: article, serializer: Api::V1::ArticleSerializer
   end

   def create
     @article = current_user.articles.create!(article_params)
     render json: @article, serializer: Api::V1::ArticleSerializer
   end

   def update
     # 対象のレコードを探す
     article = current_user.articles.find(params[:id])
     # 探してきたレコードに対して変更を行う
     article.update!(article_params)
     render json: article, serializer: Api::V1::ArticleSerializer
   end

   def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
   end

   private

   def article_params
     params.require(:article).permit(:title, :body)
   end
 end
end
