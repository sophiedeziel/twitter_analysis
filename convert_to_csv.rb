require 'rubygems'
require 'json'
require 'builder'
require 'csv'


def get_json_from_file(filename)
  json = File.read(filename)
  JSON.parse(json)
end

def convert_to_csv(filename)
  tweets = get_json_from_file(filename)
  c = tweets.count
  i = 0

  CSV.open(File.basename(filename, '.*') + '.csv', 'wb') do |csv|
    csv << %w(id lang created_at source in_reply_to_status_id in_reply_to_user_id in_reply_to_screen_name user_id user_location user_followers_count user_friends_count user_time_zone, user_statuses_count, user_lang, place_full_name, place_country_code, geo_x, geo_y, is_good)

  end



  tweets.each do |t|

    i += 1
    puts "================================"
    puts "\ntweet #{i} of #{c}"
    puts "--------------------------------"
    puts "\n\n#{t['text']} \n\n"
    is_good = prompt "Is about the animal?"
    if is_good == 'q'
      exit
    end
    CSV.open(File.basename(filename, '.*') + '.csv', 'ab') do |csv|
      csv << [t['id'],
              t['lang'],
              t['created_at'],
              t['source'],
              t['in_reply_to_status_id'],
              t['in_reply_to_user_id'],
              t['in_reply_to_screen_name'],
              t['user']['id'],
              t['user']['location'],
              t['user']['followers_count'],
              t['user']['friends_count'],
              t['user']['time_zone'],
              t['user']['statuses_count'],
              t['user']['lang'],
              t['place'] ? t['place']['full_name'] : nil,
              t['place'] ? t['place']['country_code'] : nil,
              t['geo'] ? t['geo']['coordinates'].first : nil,
              t['geo'] ? t['geo']['coordinates'].last : nil,
              is_good
      ]
    end
  end
  true
end

def prompt message
  puts "#{message} "
  $stdout.flush
  system("stty raw -echo")
  c = STDIN.getc
  system("stty -raw echo")
  c
end

filename = ARGV[0]
convert_to_csv filename



