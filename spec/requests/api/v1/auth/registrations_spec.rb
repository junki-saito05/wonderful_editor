require 'rails_helper'

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    context "必要な情報が存在するとき" do
      let(:params) { attributes_for(:user) }
      it "ユーザーの新規登録ができる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = JSON.parse(response.body)
        expect(res["data"]["email"]).to eq(User.last.email)
      end
      it "header 情報を取得することができる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end
    context "name が存在しないとき" do
      let(:params) { attributes_for(:user, name: nil) }
      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end
    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, email: nil) }
      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end
    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }
      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end

# RSpec.describe "Api::V1::Auth::RegistrationsController", type: :request do
#   describe 'POST /api/v1/auth' do
#     let(:valid_attributes) do
#       { name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password' }
#     end

#     context 'when the request is valid' do
#       before { post '/api/v1/auth', params: valid_attributes }

#       fit 'creates a new user' do
#         expect(response).to have_http_status(:created)
#       end

#       it 'returns success message' do
#         expect(JSON.parse(response.body)['message']).to eq('新規登録が完了しました。')
#       end

#       it 'returns access token' do
#         expect(response.headers['access-token']).to be_present
#       end
#     end

#     context 'when the request is invalid' do
#       before { post '/api/v1/auth', params: { email: 'invalid_email' } }

#       it 'returns an error message' do
#         expect(JSON.parse(response.body)['errors']).to eq(['Eメールは不正な値です'])
#       end

#       it 'returns a status code of 422' do
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end
# end
