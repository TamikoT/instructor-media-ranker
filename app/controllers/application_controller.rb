class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def find_user
    unless session[:user_id].nil?
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def require_login
    if @login_user.nil?
      flash[:result_text] = "You must be logged in!!!"

      redirect_to root_path
    end
  end
end
