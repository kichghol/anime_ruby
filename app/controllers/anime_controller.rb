class AnimeController < ApplicationController
  def index
  end
  
  def search
    animes = find_anime(params[:anime])
    unless animes
      flash[:alert] = 'Animé introuvable'
      return render action: :index
    end
    @anime= animes.first
  end


 private
  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host
      
      }
     
    )
    
    return JSON.parse(response.body)
  end
  def find_anime(name)
    request_api(
      "http://localhost:5000/users/#{URI.encode(name)}"
    )
  end

end
