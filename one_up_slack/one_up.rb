require "sinatra"
require "json"

get '/' do
  'Hello world!'
end

post "/incoming" do
  content_type :json
  {
    "text" => "It's 80 degrees right now.",
    "attachments" => [
        {
            "text" => "Partly cloudy today and tomorrow #{params.inspect}"
        }
    ]
  }.to_json
end