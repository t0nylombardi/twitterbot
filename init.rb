#--
#   init.rb
#   $Id$
#++

APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib') )

# require gems 
require 'twitter'
require 'tweetstream'
require 'active_support/all'
#local files 
require 'bot'

# bypasses Ruby not being able to find the  
# certification authority certificates (CA Certs) used 
# to verify the authenticity of secured web servers.  
silence_warnings do
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end

bot = Bot.new(ARGV.shift)
bot.launch!

