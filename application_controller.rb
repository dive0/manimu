require 'dotenv/load'
require 'bundler'
Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/result' do
    @user_name = params[:name]
    @user_anime_manga = Anime_and_manga.new(@user_name)
    @user_anime_manga.get_info
    
    erb :result
  end
  
end
