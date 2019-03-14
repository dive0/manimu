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
    @airing_img = []
    @airing_info = []
    
    airing_array["top"][0..9].each do |anime|
      anime.each do |key, value|
        if key == "image_url"
          @airing_img << value
        elsif key == "title"
          @airing_info << value
        elsif key == "rank"
          @airing_info << "Rank: " + value.to_s
        elsif key == "episodes"
          @airing_info << "Episodes: " + value.to_s
        elsif key == "score"
          @airing_info << "Score: " + value.to_s
        end
      end
    end
    
    top_anime_url = "https://api.jikan.moe/v3/top/anime/1"
    top_anime_uri = URI(top_anime_url)
    top_anime_response = Net::HTTP.get(top_anime_uri)
    pp top_anime_array = JSON.parse(top_anime_response)
    
    
    erb :index
  end
  
  post '/result' do
    @user_name = params[:name]
    @user_anime_manga = Anime_and_manga.new(@user_name)
    @user_anime_manga.get_info
    
    erb :result
  end
  
end
