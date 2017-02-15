class PsongsController < ApplicationController
  def create
    user_playlist = User.find(session[:user_id]).playlist
    song = Song.find(params[:psong][:song_id])
    psong = Psong.new(playlist: user_playlist, song: song)
    if psong.save
      flash[:success] = "Song added to playlist!"
      redirect_to controller: "users", action: "show", id: session[:user_id]
    else
      flash[:error] = "Something went wrong"
      redirect_to controller: "songs", action: "index"
    end
  end
end
