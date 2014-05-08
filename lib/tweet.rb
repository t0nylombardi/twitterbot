#--
#   lib/tweet.rb
#   $Id$
#++

class Tweet

  @@filepath = nil
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end
  
  attr_accessor :name, :cuisine, :price
  
  def self.file_exists?
    # class should know if the tweets file exists
    @@filepath && File.exists?(@@filepath) ? true : false  
  end
  
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.saved_tweets
    tweets    =   []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        tweets << line
      end
      file.close
    end
    tweets
  end
    
end