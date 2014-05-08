require 'twitter'
require 'tweetstream'
require 'active_support/all'

# bypasses Ruby not being able to find the 
# certification authority certificates (CA Certs) used 
# to verify the authenticity of secured web servers.  
silence_warnings do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end

# global varibles that are needed. 
count     =   1
tweets    =   []
text_file =   ARGV.shift 
keywords  =   [] 
keywords  +=  ARGV


api_keys = {  consumer_key:        'CONSUMER KEY GOES HERE',
              consumer_secret:     'CONSUMER SECRET GOES HERE',
              access_token:        'ACCESS TOKEN GOES HERE',
              access_token_secret: 'ACCESS TOKEN SECRET' }


file = File.open(text_file, "r").each_line do |line|
  tweets << line
end
file.close

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = api_keys[:consumer_key]
  config.consumer_secret     = api_keys[:consumer_secret]
  config.access_token        = api_keys[:access_token]
  config.access_token_secret = api_keys[:access_token_secret]
end

TweetStream.configure do |config|
  config.consumer_key         = api_keys[:consumer_key]
  config.consumer_secret      = api_keys[:consumer_secret]
  config.oauth_token          = api_keys[:access_token]
  config.oauth_token_secret   = api_keys[:access_token_secret]
  config.auth_method          = :oauth
end

puts "connected ...\n"

begin
  TweetStream::Client.new.on_error do |message|
    puts message
    break
  end.track(keywords.join(",")) do |status|
    tweetn = rand(0..tweets.count)
    sleepn = rand(1..120)# anywhere from 1sec -2mins 
    client.update("@#{status.user.screen_name} #{tweets[tweetn]}")
    printf "%-5s %s\n",
          "#{count}: #{status.user.screen_name.rjust(10)}", tweets[tweetn]
    sleep sleepn
    count += 1  
  end
rescue Twitter::Error::Unauthorized
  break
rescue Twitter::Error
  sleep(200)
rescue Twitter::Error::ServiceUnavailable
  puts "Service is unavailable waiting for 5 minutes..."
  sleep(60*5)
  retry
  puts "This request looks like it might be automated."
rescue Exception
  puts "some other error happened!"
end