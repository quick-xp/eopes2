class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  def get_current_user_id
    1
  end
end
