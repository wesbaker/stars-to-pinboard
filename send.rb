require 'httparty'
require 'thumbtack'
require 'dotenv'

Dotenv.load

def get_data
  url = "https://api.github.com/users/#{ENV['PINBOARD_USERNAME']}/starred"
  response = HTTParty.get(url)
  response.parsed_response
end

def client
  Thumbtack::Client.new(ENV['PINBOARD_USERNAME'], ENV['PINBOARD_API_KEY'])
end

def send_link(url, description)
  client.posts.add(url, description, tags: ['programming'])
end

def main
  get_data.each do |star|
    url = star['html_url']
    description = "#{star['full_name']}: #{star['description']}"
    send_link(url, description)
  end
end

main
