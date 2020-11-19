class AnimeController < ApplicationController
  def index
    @list = [
      { 
        :title => "jimyy"
      },

      {
        :title => "nora"

      }
    ]


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
    
		return nil if response.status != 200
    return JSON.parse(response.body)
  end
  def find_anime(title)
    request_api(
      "http://localhost:5000/api/v1/animes/#{URI.encode(title)}"
    )
  end

end
