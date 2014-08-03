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
    csv << %w(id lang created_at source in_reply_to_status_id in_reply_to_user_id in_reply_to_screen_name user_id user_location user_followers_count user_friends_count user_time_zone user_statuses_count user_lang place_full_name place_country_code geo_x geo_y is_good)
  end

  @pid = nil

  tweets.each do |t|
    system("osascript -e 'tell application \"safari\" to quit'")
    system('clear')
    i += 1
    puts "================================"
    puts "tweet #{i} of #{c}"
    puts "--------------------------------"
    puts "\n\n#{t['text']} \n\n"

    if t['entities']['media'] && t['entities']['media'].any?
      @pid = open_link t['entities']['media'].first['media_url']
    end

    if t['entities']['urls'] && t['entities']['urls'].any?
      @pid = open_link t['entities']['urls'].first['expanded_url']
    end

    is_good = prompt "Is about the animal?"
    if is_good == 'q'
      system("osascript -e 'tell application \"safari\" to quit'")
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
              t['user']['time_zone'] ? t['user']['time_zone'] : nil,
              t['user']['statuses_count'],
              t['user']['lang'],
              t['place'] ? t['place']['full_name'] : '',
              t['place'] ? t['place']['country_code'] : '',
              t['geo'] ? t['geo']['coordinates'].first : 0,
              t['geo'] ? t['geo']['coordinates'].last : 0,
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

def open_link link
  pid = Process.spawn( "open -a Safari -g #{link}" )
  pid
end

filename = ARGV[0]
convert_to_csv filename



