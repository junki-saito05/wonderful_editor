class Api::V1::BaseApiController < ApplicationController
  #include DeviseTokenAuth::Concerns::SetUserByToken
  alias_method :current_user, :current_api_v1_user
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :user_signed_in?, :api_v1_user_signed_in?
  #before_action :authenticate_user!, only: [:create, :update, :destroy]

  # def current_user
  #   @current_user ||= User.first
  # end
  # ここに共通処理を実装する
end
