class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize()
    @word = ''
    @guesses = ''
    @wrong_guesses = ''
    @timeZoneCheck = ''
    @currTemp = "-69"
    
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @currWeather = 'None'
    @currTemp = "-69"
    @currRain = '-69'
    
  end
  

  def word
    @word
  end
  
  def word=(str)
    @word = str
  end

  def guesses
    @guesses
  end

  def guesses=(str)
    @guesses = str
  end
  
  def wrong_guesses
    @wrong_guesses
  end
  
  def timeZoneCheck
    @timeZoneCheck
  end
  
  def currWeather
    @currWeather
    
  end
  
  def currRain
    @currRain
    
  end
  
  def currTemp
    @currTemp
  end
  
  def wrong_guesses=(str)
    @wrong_guesses = str
  end
  
  def guess(g)
    if (g == nil) || (g == '') || (g =~ /\W/) 
      raise ArgumentError
    end
    if @wrong_guesses =~ /#{g}/i
      return false
    else
      if (@word =~ /#{g}/i)
        
        if !(@guesses =~ /#{g}/i)
          
          @guesses << g
          #put @guesses
          return true
        end
        return false
        
      else
        
        @wrong_guesses << g
        #put @wrong_guesses
        
      end
    end
    return true #I don't get why it's true if you guess incorrectly, but whatever, Shikata ga nai
  end
  
  def word_with_guesses
    outword = ''
    chars = @word.split('')
    for l in chars
      if (@guesses.include? l)
        outword << l
      else
        outword << '-'
      end
    end
    return outword
  end
  
  def check_win_or_lose
    if @guesses == ''
      return :play
    end
    if @wrong_guesses.length == 1
      return :lose
    end
    
    if !(@word =~ /[^#{@guesses}]/)
      return :win
    end
    
    return :play
  end
    

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
    
    
  end
  
  def update_curr(lat, long)
    inLat = lat.to_s
    inLong = long.to_s
    require 'uri'
    require 'net/http'
    require 'json'
    url = 'https://api.darksky.net/forecast/8c7f074863e3a66f8e8b76c2dfee5ba6/' + inLat + ',' + inLong
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @currWeather = JSON.parse(response)["currently"]["summary"]
    @currTemp = JSON.parse(response)["currently"]["temperature"]
    @currRain = JSON.parse(response)["currently"]["precipProbability"]
    return currTemp

    
    
  end
  
  def get_address_lat(address)
    
    splitAddr = address.split(' ')
    
    finAddr = ''
    
    for i in 0..splitAddr.length - 2
      finAddr = finAddr + splitAddr[i] + '+'
    end
    
    finAddr = finAddr + splitAddr[splitAddr.length-1]
    
    
    require 'uri'
    require 'net/http'
    require 'json'
    url = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + finAddr + '&key=AIzaSyCYTatJM3lH_zJwNcDXhfR3fGU7k-EHd-g'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    googleOutputJSON = JSON.parse(response)
    addrLat = googleOutputJSON["results"][0]["geometry"]["location"]["lat"]
    
    return addrLat
    
  end
  
  def get_address_long(address)
    
    splitAddr = address.split(' ')
    
    finAddr = ''
    
    for i in 0..splitAddr.length - 2
      finAddr = finAddr + splitAddr[i] + '+'
    end
    
    finAddr = finAddr + splitAddr[splitAddr.length-1]
    
    
    require 'uri'
    require 'net/http'
    require 'json'
    url = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + finAddr + '&key=AIzaSyCYTatJM3lH_zJwNcDXhfR3fGU7k-EHd-g'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    googleOutputJSON = JSON.parse(response)
    addrLong = googleOutputJSON["results"][0]["geometry"]["location"]["lng"]
    return addrLong
  end

end

