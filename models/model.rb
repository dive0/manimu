#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pp'

# Fetch and parse HTML document
pp anime_link = Nokogiri::HTML(open('https://www.animenewsnetwork.com/encyclopedia/reports.xml?title=4658'))
