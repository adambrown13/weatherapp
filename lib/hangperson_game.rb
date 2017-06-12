class HangpersonGame

  
  
  def initialize()
    @currWeather = 'None'
    @currTemp = "-88"
    @currRain = '-88'
    @currLoc = ''
    @previous = []
    
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
  
  def currLoc
    @currLoc
  end
    
  
  def update_curr(address)
    quickPack = [@currLoc, @currWeather, @currTemp, @currRain]
    @previous = @previous + quickPack
    googleJSON = get_address(address)
    inLat = googleJSON["results"][0]["geometry"]["location"]["lat"].to_s
    inLong = googleJSON["results"][0]["geometry"]["location"]["lng"].to_s
    require 'uri'
    require 'net/http'
    require 'json'
    url = 'https://api.darksky.net/forecast/8c7f074863e3a66f8e8b76c2dfee5ba6/' + inLat + ',' + inLong
    uri = URI(url)
    response = Net::HTTP.get(uri)
    darkSkyJSON = JSON.parse(response)
    @currWeather = darkSkyJSON["currently"]["summary"]
    @currTemp = darkSkyJSON["currently"]["temperature"]
    @currRain = darkSkyJSON["currently"]["precipProbability"]
    @currLoc = googleJSON["results"][0]["formatted_address"]
    return currTemp

    
    
  end
  
  def get_address(address)
    
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
    return googleOutputJSON
    
  end
  

end

