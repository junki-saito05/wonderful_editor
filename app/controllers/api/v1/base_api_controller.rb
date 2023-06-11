class Api::V1::BaseApiController < ApplicationController
  before_action :authenticate_user!

  # ここに共通処理を実装する
end
