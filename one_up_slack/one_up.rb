require "sinatra"
require "json"
require 'net/http'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "parser"

get '/' do
  'Hello world!'
end

post "/incoming" do
  content_type :json
  delayed_response(params["response_url"], params)
  status 200
end

def delayed_response(response_url, params)
  uri = URI(response_url)
  Net::HTTP.start(uri.host, uri.port) do |http|
    req = Net::HTTP::Post.new(response_url)

    text = Parser.new(params["text"]).parse
    username = params["user_name"]
    body = payload(username, text.receiver, text.message, text.gift).to_json
    req.body = body

    req["Content-Type"] = "application/json"
    res = http.request req
    puts response.inspect
  end
end

def payload(username, receiver, message, gift)
  {
    "response_type": "in_channel",
    "text" => "<@#{username}> sent a #{gift} to <#{receiver}>",
    "attachments" => [
        {
            "text" => "#{message}",
            "color" => "good"
        }
    ]
  }
end
