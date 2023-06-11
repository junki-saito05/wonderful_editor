class Api::V1::BaseApiController < ApplicationController
  #before_action :authenticate_user!

  def current_user
    @current_user ||= User.first
  end
  # ここに共通処理を実装する
end
