class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
        protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
end
