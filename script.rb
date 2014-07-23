#!/usr/bin/env ruby
$stdout.sync = true
require 'twitter'

def is_number?(obj)
    obj.to_s == obj.to_i.to_s
end

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
end

def run_searches(list, goal)
  list.each do |keyword|
    get_tweets(keyword, goal)
  end
end

def get_tweets(keyword, goal)
  json_file = seach(keyword, goal)
  puts " de l'objectif trouvees. Total de #{json_file.count} tweets."
  filename = keyword + '-' + json_file.count.to_s + '.json'
  save_file(filename, json_file)
end

def seach(keyword, goal)
  json_file = []
  max_id = nil
  while json_file.count < goal do
    results = twitter_request(keyword, 100, max_id)
    break if results[:statuses].empty?
    results[:statuses].each do |t|
      json_file << t
    end
    max_id = results[:statuses].last[:id] - 1
    print "\r#{(json_file.count * 1.0 / goal * 100).round}%"
    sleep 3
  end
  json_file
end

def twitter_request(keyword, count, max_id)
  if max_id.nil?
    search = @client.search(keyword, :count => count, :result_type => "recent")
  else
    search = @client.search(keyword, :count => count, :max_id => max_id, :result_type => "recent")
  end
  search.to_h
end

def save_file(filename, json_file)
  File.open(filename, 'w') { |file| file.write(json_file.to_json) }
  puts "Fichier enregistre : #{filename}, #{File.size(filename)} bytes"
  true
end

def check_args(args)
  if args.count <= 1
    raise "Invalid number of arguments (2 or more, got #{ARGV.count})"
  end
    
  unless is_number? args.first
    raise "Target is not a number."
  end
end

check_args(ARGV)

goal = ARGV.shift.to_i
list = ARGV


run_searches(list, goal)
    
