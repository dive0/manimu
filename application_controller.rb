require 'dotenv/load'
require 'bundler'
require 'net/http'
require 'json'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    airing_url = 'https://api.jikan.moe/v3/top/anime/1/airing'
    airing_uri = URI(airing_url)
    airing_response = Net::HTTP.get(airing_uri)
    airing_array = JSON.parse(airing_response)
    
    pp airing_array["top"]
    
    erb :index
  end
  
  post '/result' do
    @user_name = params[:name]
    @user_anime_manga = Anime_and_manga.new(@user_name)
    @user_anime_manga.get_info
    
    erb :result
  end
  
end
