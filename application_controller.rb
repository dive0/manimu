require 'dotenv/load'
require 'bundler'
require 'net/http'
require 'json'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    # parse json for top currntly airing anime
    airing_url = 'https://api.jikan.moe/v3/top/anime/1/airing'
    airing_uri = URI(airing_url)
    airing_response = Net::HTTP.get(airing_uri)
    airing_array = JSON.parse(airing_response)
    @airing_img = []
    @airing_info = []
    
    # grab the information for the top 10 airing anime
    airing_array["top"][0..9].each do |anime|
      anime.each do |key, value|
        if key == "image_url"
          @airing_img << value
        elsif key == "title"
          @airing_info << value
        elsif key == "type"
          @airing_info << "Type: " + value
        elsif key == "rank"
          @airing_info << "Rank: " + value.to_s
        elsif key == "episodes"
          if value == nil
            @airing_info << "Episodes: Unknown"
          else
            @airing_info << "Episodes: " + value.to_s
          end
        elsif key == "score"
          @airing_info << "Score: " + value.to_s
        end
      end
    end
    
    # parse json for top anime
    top_anime_url = "https://api.jikan.moe/v3/top/anime"
    top_anime_uri = URI(top_anime_url)
    top_anime_response = Net::HTTP.get(top_anime_uri)
    top_anime_array = JSON.parse(top_anime_response)
    @top_anime_info = []
    @top_anime_img = []
    
    # grab the information for the top 10 anime
    top_anime_array["top"][0..9].each do |anime|
      anime.each do |key, value|
        if key == "image_url"
          @top_anime_img << value
        elsif key == "title"
          @top_anime_info << value
        elsif key == "type"
          @top_anime_info << "Type: " + value
        elsif key == "rank"
          @top_anime_info << "Rank: " + value.to_s
        elsif key == "episodes"
          if value == nil
            @top_anime_info << "Episodes: Unknown"
          else
            @top_anime_info << "Episodes: " + value.to_s
          end
        elsif key == "score"
          @top_anime_info << "Score: " + value.to_s
        end
      end
    end
    
    # parse json for top manga
    top_manga_url = "https://api.jikan.moe/v3/top/manga"
    top_manga_uri = URI(top_manga_url)
    top_manga_response = Net::HTTP.get(top_manga_uri)
    top_manga_array = JSON.parse(top_manga_response)
    @top_manga_info = []
    @top_manga_img = []
    
    # grab the information for the top 10 manga
    top_manga_array["top"][0..9].each do |manga|
      manga.each do |key, value|
        if key == "image_url"
          @top_manga_img << value
        elsif key == "title"
          @top_manga_info << value
        elsif key == "type"
          @top_manga_info << "Type: " + value
        elsif key == "rank"
          @top_manga_info << "Rank: " + value.to_s
        elsif key == "volumes"
          if value == nil
            @top_manga_info << "Volumes: Unknown"
          else
            @top_manga_info << "Volumes: " + value.to_s
          end
        elsif key == "score"
          @top_manga_info << "Score: " + value.to_s
        end
      end
    end
    
    erb :index
  end
  
  post '/result' do
    @user_name = params[:name] # store user input
    @user_anime_manga = Anime_and_manga.new(@user_name) # get information about the title inputted
    @user_anime_manga.get_info
    
    erb :result
  end
  
end
