require 'sinatra/base'
require 'sinatra/flash'
require './lib/hangperson_game.rb'

class HangpersonApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || HangpersonGame.new()
  end
  
  after do
    session[:game] = @game
  end
  
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    @game = HangpersonGame.new()
    redirect '/show'
  end
  
  post '/address' do
    
    if params[:addr].length == 0
      redirect '/new'
    end
    
    #@game.currTempAPIPull = HangpersonGame.get_curr_temp
    address = params[:addr].to_s
    
    if @game.get_address(address)["results"].length == 0
      
      flash[:message] = "Address Not Found"
      redirect '/new'
    
    end
    
    @game.update_curr(address)#@game.get_address_lat(address), @game.get_address_long(address))
    
    redirect '/show'
  end

  get '/show' do
    erb :show
  end
  
  get '/lose' do
    erb :lose
  end
  
end
