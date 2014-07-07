#--
#   lib/bot.rb
#   $Id$
#++
require 'tweet'
class Bot

  def initialize(path=nil)
    # locate the tweet text file at path
    Tweet.filepath = path
    if Tweet.file_usable?
      puts "Found tweet file."
    else
      puts "Exiting.\n\n"
      exit!
    end

    @api_keys = {   consumer_key:        'CONSUMER KEY GOES HERE',
                    consumer_secret:     'CONSUMER SECRET GOES HERE',
                    access_token:        'ACCESS TOKEN GOES HERE',
                    access_token_secret: 'ACCESS TOKEN SECRET' }
    
    @count     =   1
    @tweets    =   Tweet.saved_tweets
    @keywords  =   [] 
    @keywords  +=  ARGV
  end

  def launch!
    run_bot
  end

  def run_bot

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @api_keys[:consumer_key]
      config.consumer_secret     = @api_keys[:consumer_secret]
      config.access_token        = @api_keys[:access_token]
      config.access_token_secret = @api_keys[:access_token_secret]
    end

    TweetStream.configure do |config|
      config.consumer_key         = @api_keys[:consumer_key]
      config.consumer_secret      = @api_keys[:consumer_secret]
      config.oauth_token          = @api_keys[:access_token]
      config.oauth_token_secret   = @api_keys[:access_token_secret]
      config.auth_method          = :oauth
    end

    puts "connected ...\n"

    begin
      TweetStream::Client.new.on_error do |message|
        puts message
        break
      end.track(@keywords.join(",")) do |status|
        tweetn = rand(0..@tweets.count)
        sleepn = rand(1..120)# anywhere from 1sec -2mins 
        client.update("@#{status.user.screen_name} #{@tweets[tweetn]}")
        printf "%-5s %s\n",
          "#{@count}: #{status.user.screen_name.rjust(10)}", @tweets[tweetn]
        sleep sleepn
        @count += 1  
      end
    rescue Twitter::Error::Unauthorized
      abort("Unauthorized.")
    rescue Twitter::Error
      sleep(200)
    rescue Twitter::Error::ServiceUnavailable
      puts "Service is unavailable waiting for 5 minutes..."
      sleep(60*5)
      retry
      puts "This request looks like it might be automated."
    rescue Exception => e
      puts e
    end
  end
end

