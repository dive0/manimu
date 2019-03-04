#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pp'

class Anime_and_manga
    attr_reader :name, :combined_info, :types
    
    def initialize(name)
        @name = name
        @combined_info = []
    end
    
    def get_info
        pp anime_manga = Nokogiri::HTML(open('https://cdn.animenewsnetwork.com/encyclopedia/api.xml?title=~'+@name))
        
        anime_manga.children.each do |item1|
            item1.children.each do |item2|
                item2.children.each do |item3|
                    item3.children.each do |item4|
                        @combined_info << item4.attributes["name"].value + " (" + item4.attributes["type"].value.capitalize + ")"
                        @combined_info << item4.children
                        # end
                    end
                end
            end
        end
    end
end



