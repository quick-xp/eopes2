class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def get_current_user_id
    1
  end
end
