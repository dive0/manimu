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
        # begin
        anime_manga = Nokogiri::HTML(open('https://cdn.animenewsnetwork.com/encyclopedia/api.xml?title=~'+@name))
        
        anime_manga.children.each do |item1|
            item1.children.each do |item2|
                item2.children.each do |item3|
                    item3.children.each do |item4|
                        
                        @combined_info << item4.attributes["name"].value + " (" + item4.attributes["type"].value + ")"
                        # pp item4.children
                        # pp item4.children[5].attributes["src"].value
                        item4.children.each do |item5|
                            if item5.attributes.include?("src") == true
                                @images << item5.attributes["src"].value
                            end
                        end
                        
                        
                    end
                end
            end
        end
        # rescue
        #     @combined_info = ["Sorry, Anime/Manga not found"]
        # end
    end
end