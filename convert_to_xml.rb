require 'rubygems'
require 'json'
require 'builder'

def get_json_from_file(filename)
  json = File.read(filename)
  JSON.parse(json)
end

def convert_to_xml(filename)
  tweets = get_json_from_file(filename + '.json')
  file = File.new(filename + '.xml', "wb")
  xml = Builder::XmlMarkup.new( :indent => 2, :target => file )
  xml.instruct! :xml, :encoding => "utf-8"
  xml.searchresult do |d|
    d.query '#tiger'

    tweets.each do |t|
      d.document(:id => t['id']) do |dt|
        dt.title t['text']
        dt.url "https://twitter.com/#{t['user']['screen_name']}/status/#{t['id']}"
        dt.snippet  t['text']
      end
    end


  end

  file.close
  true
end