class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize()
    @word = ''
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
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
    if @wrong_guesses.length == 7
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

end
