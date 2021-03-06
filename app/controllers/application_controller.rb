class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user
  before_action :require_login

  def render_404
    # DPR: this will actually render a 404 page in production
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user.nil?
      flash[:status] = :failure
      flash[:error] = 'You must be logged in to view this section'
      redirect_to root_path
    end
  end

  def find_user
    @login_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
