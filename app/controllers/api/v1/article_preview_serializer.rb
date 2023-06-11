class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at
  belongs_to :user, serializer: Api::V1::UserSerializer

  # has_many :comments など、記事に関連するオブジェクトがあれば追加していく
end
