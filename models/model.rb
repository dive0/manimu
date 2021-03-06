#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pp'

class Anime_and_manga
    attr_reader :name, :combined_info, :types, :images
    
    def initialize(name)
        @name = name
        @combined_info = []
        @images = []
    end
    
    def get_info
        begin
            #parse xml
            anime_manga = Nokogiri::HTML(open('https://cdn.animenewsnetwork.com/encyclopedia/api.xml?title=~'+@name))
        
            #iterating through the hash
            anime_manga.children.each do |item1|
                item1.children.each do |item2|
                    item2.children.each do |item3|
                        item3.children.each do |item4|
                        #shovel the inforamtion into an array if the value is equal to the specified string
                            @combined_info << "Title: " + item4.attributes["name"].value + " (" + item4.attributes["type"].value + ")"
                            item4.children.each do |item5|
                                if item5.attributes.include?("type") == true
                                    if item5.attributes["type"].value == "Genres"
                                        @combined_info << "Genres: " + item5.children[0]
                                    
                                    elsif item5.attributes["type"].value == "Number of episodes"
                                        @combined_info << "Number of Episodes: " + item5.children[0]
                                    
                                    elsif item5.attributes["type"].value == "Number of pages"
                                        @combined_info << "Number of Pages: " + item5.children[0]
                                    
                                    elsif item5.attributes["type"].value == "Vintage"
                                        @combined_info << "Vintage: " + item5.children[0]
                                    
                                    elsif item5.attributes["type"].value ==   "Plot Summary"
                                        @combined_info << "Plot Summary: " + item5.children[0]
                                    end 
                                end

                                #get the link of the images
                                if item5.attributes.include?("src") == true
                                @images << item5.attributes["src"].value
                                end
                            end
                        end
                    end
                end
            end
        rescue
            @combined_info << "Sorry, Anime and or Manga not found"
        end
    end
end