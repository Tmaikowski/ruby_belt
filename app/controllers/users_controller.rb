class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def show
    @user = User.find(session[:user_id])
    @songs = @user.playlist.songs.group(:song_id, :artist, :title).count
  end

  def create
    user = User.new(user_params)
    if user.save
      Playlist.create(user: user)
      session[:user_id] = user.id
      redirect_to '/songs'
    else
      flash[:notice] = user.errors.messages
      redirect_to '/'
    end
  end

  def update
    user = User.find(session[:user_id])
    user.update_attributes(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      city: params[:user][:city],
      state: params[:user][:state]
    )
    p "*"*50
    p user.errors
    p "*"*50
    redirect_to action: 'edit', id: session[:user_id]
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if !user
      flash[:email_error] = "Invalid email address"
      return redirect_to '/'
    end
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to '/songs'
    else
      flash[:pw_error] = "Invalid password"
      redirect_to '/'
    end
  end

  def logout
    session.clear
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :city,
      :state,
      :password,
      :password_confirmation
    )
  end

  def user_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :city,
      :state
    )
  end
end
