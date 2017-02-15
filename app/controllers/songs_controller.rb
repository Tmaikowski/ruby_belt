class SongsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @songs = Song.all
    @song = Song.new
    @psong = Psong.new
    @song_count = Psong.group(:song_id).count
  end

  def create
    song = Song.new(title: params[:song][:title], artist: params[:song][:artist])
    if song.save
      flash[:success] = "Song added to the hub!"
    else
      flash[:notice] = song.errors.full_messages
    end
    redirect_to '/songs'
  end

  def show
    @song = Song.find(params[:id])
    @psong = Psong.all.where(song_id: @song.id).group(:playlist_id).count
    @users = User.all
    # @songs = @user.playlist.songs.group(:song_id, :artist, :title).count
  end
end
