require 'sinatra/base'
require 'pg'
require './lib/space'

class Dinosaur_Bnb < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
  end

  get '/create' do
    erb(:create)
  end

  post '/new-space' do
    Spaces.create(name: params[:property_name], description: params[:description], price: params[:price_per_night], available_from: params[:available_from], available_to: params[:available_to])
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Spaces.all.reverse
    erb :spaces
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    # params[:name]
    # params[:username]
    # params[:email]
    # params[:password]
    redirect '/login'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    redirect '/spaces'
  end

  post '/spaces/edit' do
    session['edit_space'] = Spaces.find('id', params[:Edit])
    redirect '/spaces/edit'
  end

  get '/spaces/edit' do
    @edit_space = session['edit_space']
    erb :edit
  end

  post '/spaces/update' do
    Spaces.update(id: session['edit_space'].id, name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to])
    redirect '/spaces'
  end

  run! if app_file == $0
end
