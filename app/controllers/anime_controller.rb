class AnimeController < ApplicationController
  def index
    @list = [
      { 
        :title => "jimyy"
      },

      {:title => "nora"

      }
    ]


  end
  
  def search
    animes = find_anime(params[:anime])
    unless animes
      flash[:alert] = 'Animé introuvable'
      return render action: :index
    end
    @animes= animes
    
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
    puts title
    request_api(
      "https://animelist-api.herokuapp.com/api/v1/animes?title=#{URI.encode(title)}"
    )
  end

end
