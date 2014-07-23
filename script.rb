require 'Twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'J4ATZUUIiRMZhuxhnOp2uC3ge'
  config.consumer_secret = 'kR49QgidxoNO27ojzfVP17irWzER6EgTOQtAHWDFxAyjtUNSBG'
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