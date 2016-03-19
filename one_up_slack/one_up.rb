require "sinatra"
require "json"
require 'net/http'
require "sucker_punch"

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "parser"

get '/' do
  'Hello world!'
end

class SlackResponseJob
  include ::SuckerPunch::Job

  def perform(response_url, params)
    sleep 1
    uri = URI(response_url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      req = Net::HTTP::Post.new(response_url)

      text = Parser.new(params["text"]).parse
      username = params["user_name"]
      channel = params["channel_name"]
      body = payload( username,
                      text.receiver,
                      text.message,
                      text.gift,
                      channel ).to_json
      req.body = body

      req["Content-Type"] = "application/json"
      puts req.inspect
      res = http.request req
      puts res.inspect
    end
  end

  def payload(username, receiver, message, gift, channel)
    {
      "access_token": ENV["SLACK_BOT_TOKEN"],
      "response_type": "in_channel",
      "text" => "<@#{username}> sent a #{gift} to <#{receiver}>",
      "channel" => "#{channel}",
      "attachments" => [
          {
              "text" => "#{message}",
              "color" => "good"
          }
      ]
    }
  end
end

post "/incoming" do
  content_type :json
  puts params.inspect
  SlackResponseJob.perform_async(params["response_url"], params)
  {
    "response_type" => "ephemeral",
    "text" => "Gotcha, sending a 1up"
  }.to_json
  end

