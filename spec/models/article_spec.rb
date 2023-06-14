# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default(NULL), not null
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
  describe "正常系" do
    context "タイトルと本文が入力されているとき" do
      let(:article) { build(:article) }

      it "下書き状態の記事が作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "draft"
      end
    end

    context "status が下書き状態のとき" do
      let(:article) { build(:article, :draft) }
      it "記事を下書き状態で作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "draft"
      end
    end

    context "status が公開状態のとき" do
      let(:article) { build(:article, :published) }
      it "記事を公開状態で作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "published"
      end
    end
  end
end

# RSpec.describe Article, type: :model do
#   context '記事を新規作成する場合' do
#     fit '下書き記事として保存できること' do
#       user = FactoryBot.create(:user)
#       article = Article.create(
#         user: user,
#         title: '下書き記事',
#         body: 'これは下書き記事です。'
#         status: 'draft'
#       )
#       expect(article).to be_valid
#       expect(article.status).to eq "draft"
#     end

#     it '公開記事として保存できること' do
#       user = FactoryBot.create(:user)
#       article = Article.create(
#         user: user,
#         title: '公開記事',
#         body: 'これは公開記事です。',
#         status: 'published'
#       )
#       expect(article).to be_valid
#       expect(article.status).to eq 'published'
#     end
#   end
# end
