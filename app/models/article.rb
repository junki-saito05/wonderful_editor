# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default(0), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  belongs_to :user

  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title,  presence: true

  enum publication_status: [:draft, :published]

  # enum status: { draft: 0, published: 1 }

  # 配列として定義
  # enum status: [:draft, :published]
  # enum status: %i(draft published)
end
