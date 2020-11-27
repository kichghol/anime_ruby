class AnimeController < ApplicationController
  def index
  end

  def add
  end
  def add_success
    @cache = ActiveSupport::Cache::MemoryStore.new() if @cache.nil?
    puts 'params'
    puts params
    puts params[:title]
    token = Rails.cache.read('currentToken')
    if token && addAnime(params, token)
      @text="Successfully added"
    else
      @text="Not connected"
    end
  end
  
  def search
    animes = find_anime(params[:anime])
    unless animes
      flash[:alert] = 'Animé introuvable'
      return render action: :index
    end
    @animes= animes
    
  end

	def destroy
    @cache = ActiveSupport::Cache::MemoryStore.new() if @cache.nil?
    token = Rails.cache.read('currentToken')
    if token && deleteAnime(params[:id], token)
			puts "DELETED"
			redirect_back(fallback_location: root_path)
      @text="Successfully added"
    else
			puts "NOT DELETED"
      @text="Not connected"
    end
	end
  def catalog
    @animes = all_animes()
  end   

  def signup
  end

  def signin 
  end 

  def signinSuccess
    @cache = ActiveSupport::Cache::MemoryStore.new() if @cache.nil?
    token = getSigninToken(params[:username], params[:password])
    if token
      Rails.cache.write('currentToken', token["auth_token"])
    end
    puts "TEST150000"
		puts params[:username]
    puts token["auth_token"]

    # redirect_to '/search'
 end

	def success
    @cache = ActiveSupport::Cache::MemoryStore.new() if @cache.nil?
		token = getToken(params[:username], params[:password], params[:password_confirmation])
    if token
      Rails.cache.write('currentToken', token["auth_token"])
    end
	end



 private

	def deleteAnime(id, token)
    response = Excon.delete("https://animelist-api.herokuapp.com/api/v1/animes/#{URI.encode(id)}",
			:headers => { "Content-Type" => "application/x-www-form-urlencoded", 'Authorization' => "Bearer #{URI.encode(token)}" })
		puts "STATUS"
		puts response.status
		return nil if response.status != 204
    return true
	end
		
  
  def addAnime(anime, token)
    puts "animeeee"
    puts anime
    response = Excon.post("https://animelist-api.herokuapp.com/api/v1/animes",
      :body => "title=#{URI.encode(anime[:title])}&author=#{URI.encode(anime[:author])}&genre=#{URI.encode(anime[:genre])}&rating=#{URI.encode(anime[:rating])}&releasedate=#{URI.encode(anime[:releasedate])}&episodenumber=#{URI.encode(anime[:episodenumber])}&image=#{URI.encode(anime[:image])}",
			:headers => { "Content-Type" => "application/x-www-form-urlencoded", 'Authorization' => "Bearer #{URI.encode(token)}" })

    puts "STATUS DE LA REPOONSE ADD ANIME"
    puts response.status
    puts response.body
		return nil if response.status != 201
    return JSON.parse(response.body)
  end


	def getToken(name, password, confirmation)
		response = Excon.post("https://animelist-api.herokuapp.com/api/v1/signup",
			:body => "name=#{URI.encode(name)}&password=#{URI.encode(password)}&rights=1&password_confirmation=#{URI.encode(confirmation)}",
			:headers => { "Content-Type" => "application/x-www-form-urlencoded" })
    
		puts response.status
		return nil if response.status != 201
    return JSON.parse(response.body)
  end

  def getSigninToken(name, password)
		response = Excon.post("https://animelist-api.herokuapp.com/api/v1/auth/login",
			:body => "name=#{URI.encode(name)}&password=#{URI.encode(password)}",
			:headers => { "Content-Type" => "application/x-www-form-urlencoded" })
    
		puts response.status
		return nil if response.status != 200
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
    puts title
    request_api(
      "https://animelist-api.herokuapp.com/api/v1/animes?title=#{URI.encode(title)}"
    )
  end

  def all_animes()
    request_api(
      "https://animelist-api.herokuapp.com/api/v1/animes"
    )
  end

end
