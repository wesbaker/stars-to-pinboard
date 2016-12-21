require 'httparty'
require 'thumbtack'
require 'dotenv'

Dotenv.load

def get_stars
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
  get_stars.each do |star|
    send_link(
      star['html_url'],
      "#{star['full_name']}: #{star['description']}"
    )
  end
end

main
