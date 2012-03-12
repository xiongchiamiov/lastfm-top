#!/usr/bin/env ruby

# May you recognize your weaknesses and share your strengths.
# May you share freely, never taking more than you give.
# May you find love and love everyone you find.

require 'json'
require 'net/http'
require 'optparse'
require 'uri'

PERIOD_OPTIONS = ['7day', '3month', '6month', '12month', :overall]
API_KEY = 'c7089003368bef3c8d0dd12ceede4978'
period = 'overall'
limit = 10

OptionParser.new do |opts|
	opts.banner = "Usage: #{$0.split('/').last} [options] [USER]"
	
	opts.on('-l', '--limit NUM', Integer, 'Number of artists to show.  '\
	                                     +'0 is all.  Defaults to 10.') do |num|
		# We should actually restrict the range a bit.  Using a really, really
		# big number causes the API to return no tracks at all.
		limit = num
	end
	
	opts.on('-p', '--period PERIOD', PERIOD_OPTIONS,
	        "Time period to show.  Choices: #{PERIOD_OPTIONS.join(',')}") do |p|
		period = p
	end
	
	opts.on('-v', '--version', 'Show the installed version of lastfm-top.') do
		puts 'lastfm-top 0.1.0'
		exit 0
	end
	
	opts.on_tail('-h', '--help', 'Show this help dialog.') do
		puts opts
		exit 0
	end
end.parse!

user = ARGV[-1] || 'xiongchiamiov'

url = URI.parse("http://ws.audioscrobbler.com/2.0/?api_key=#{API_KEY}&format=json&method=user.gettopartists&user=#{user}&period=#{period}&limit=#{limit}")
json = Net::HTTP.get_response(url).body
results = JSON.parse(json)

if results['error']
	puts "Uh oh, something went wrong: #{results['message']}"
	exit results['error']
end

artists = results['topartists']['artist']
artists.each do |artist|
	puts "#{artist['name']} - #{artist['playcount']}"
end

