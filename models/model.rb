#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pp'

# Fetch and parse HTML document
class Anime_and_manga
    attr_reader :name, :names
    
    def initialize(name)
        @name = name
        @names = []
    end
    
    def get_info
        anime_manga = Nokogiri::HTML(open('https://cdn.animenewsnetwork.com/encyclopedia/api.xml?title=~'+@name))
        
        anime_manga.children.each do |item1|
            item1.children.each do |item2|
                item2.children.each do |item3|
                    item3.children.each do |item4|
                        @names << item4.attributes["name"].value
                    end
                end
            end
        end
                
            
        
    end
    
end