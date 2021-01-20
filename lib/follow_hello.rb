require "dotenv"
require "twitter"

Dotenv.load(".env")

def login_twitter
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end
  return client
end

def perform
  client = login_twitter
  client.search("#bonjour_monde", result_type: "recent").take(10).each do |tweet|
    if tweet.user != client.user("arejlthp")
      client.follow(tweet.user)
    end
  end
end

perform
