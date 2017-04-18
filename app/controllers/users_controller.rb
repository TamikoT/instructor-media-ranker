class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    # render_404 unless @user
  end

  def github_callback
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(provider: params[:provider], git_uid: auth_hash['uid'])

    if user.nil?
      # new User is created
      user = User.from_github(auth_hash)

      if user.save
        session[:user_id] = user.id
        flash[:message] = "Welcome, #{user.username}!"
      else
        flash[:message] = "Couldn't log in."
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end

    else
      session[:user_id] = user.id
      flash[:message] = "Welcome back, #{user.username}"
    end
    redirect_to root_path
  end
end
