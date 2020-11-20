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

  def signup
  end

	def success
		token = getToken(params[:username], params[:password], params[:password_confirmation])
		puts "iciAAIAIAI"
		puts params[:username]
		puts token["auth_token"]
	end


 private
	def getToken(name, password, confirmation)
		response = Excon.post("https://animelist-api.herokuapp.com/api/v1/signup",
			:body => "name=#{URI.encode(name)}&password=#{URI.encode(password)}&rights=1&password_confirmation=#{URI.encode(confirmation)}",
			:headers => { "Content-Type" => "application/x-www-form-urlencoded" })
    
		puts response.status
		return nil if response.status != 201
    return JSON.parse(response.body)
  end

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
