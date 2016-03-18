require 'sinatra'

get '/' do
  'Hello world!'
end

post "/incoming" do
  content_type :json
  {
    "text" => "It's 80 degrees right now.",
    "attachments" => [
        {
            "text" => "Partly cloudy today and tomorrow"
        }
    ]
  }.to_json
end