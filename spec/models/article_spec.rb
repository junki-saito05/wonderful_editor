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
require 'rails_helper'

RSpec.describe Article, type: :model do
  context '記事を新規作成する場合' do
    it '下書き記事として保存できること' do
      user = FactoryBot.create(:user)
      article = Article.create(
        user: user,
        title: '下書き記事',
        body: 'これは下書き記事です。',
        publication_status: 'draft'
      )
      expect(article).to be_valid
      expect(article.publication_status).to eq 'draft'
    end

    fit '公開記事として保存できること' do
      user = FactoryBot.create(:user)
      article = Article.create(
        user: user,
        title: '公開記事',
        body: 'これは公開記事です。',
        publication_status: 'published'
      )
      expect(article).to be_valid
      expect(article.publication_status).to eq 'published'
    end
  end
end
