require "sinatra"
require "json"
require 'net/http'
require "sucker_punch"
require "httparty"

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "parser"

get '/' do
  'Hello world!'
end

class SlackResponseJob
  include ::SuckerPunch::Job

  def perform(response_url, params)
    sleep 1

    text = Parser.new(params["text"]).parse
    username = params["user_name"]
    channel = params["channel_name"]

    body = payload( username,
                    text.receiver,
                    text.message,
                    text.gift,
                    channel ).to_json

    res = HTTParty.post(
      response_url, body: body,
      headers: {'Content-Type' => 'application/json'}
    )
  end

  def payload(username, receiver, message, gift, channel)
    {
      "access_token": ENV["SLACK_BOT_TOKEN"],
      "response_type": "in_channel",
      "channel" => "#{channel}",
      "attachments" => [
          {
              "title" => "<@#{username}> sent a #{gift} to <#{receiver}>",
              "text" => "#{message}",
              "color" => "good",
              "mrkdwn_in" => ["text"],
              "thumb_url" => "http://1up.mindvalley.net/pictures/0000/0048/mushroom.png"
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

