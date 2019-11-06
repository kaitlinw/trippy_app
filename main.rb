require 'sinatra' 
require 'pg'
require 'httparty'

if settings.development? 
  require 'sinatra/reloader'
  also_reload 'models/*'
  require 'pry'
end

require_relative 'models/users'
require_relative 'models/trips'

enable :sessions

def logged_in?
  if current_user
    return true
  else
    return false
  end
end

def current_user
  find_one_user(session[:user_id])
end


def run_sql(sql)
  conn = PG.connect(ENV['DATABASE_URL'] || {dbname: "trippy_database"})
  records = conn.exec(sql)
  return records
end

# Log in or sign up
get '/' do
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/lets_go' do
  # input database add here
  create_user(params)
  erb :lets_go
end

get '/login' do
  erb :login
end

get '/home' do
  erb :home
end

























get '/colors_view' do
  erb :colors_view
end





