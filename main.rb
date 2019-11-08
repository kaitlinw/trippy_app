require 'sinatra' 
require 'pg'
require 'httparty'
require 'bcrypt'

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
  conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'trippy_database'})
  records = conn.exec(sql)
  conn.close
  return records
end

# Log in or sign up
get '/' do
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  create_user(params)
  @user = find_user_by_email(params[:email])
  session[:user_id] = @user["id"]
  redirect '/lets_go'
end

get '/lets_go' do
  @user = find_one_user(session[:user_id])
  erb :lets_go
end

get '/login' do
  erb :login
end

post '/login' do
  @user = find_user_by_email(params[:email])
  if BCrypt::Password.new(@user["password_digest"]) == params[:password]
    session[:user_id] = @user["id"]
    redirect '/home'
  else
    @denied = "Wrong Password. Try again."
    redirect '/login'
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect '/'  
end

get '/home' do
  if session[:user_id] == nil
    redirect '/'
  end
  @user = find_one_user(session[:user_id])
  @current_trip = find_current_trip_data(@user['current_trip_id'])
  puts("HERERERERE")
  p(session[:user_id])
  @user_trips = find_all_trips_from_user(session[:user_id])
  
  erb :home
end


# TRIP ROUTES

get '/set_current_trip' do
  @user_trips = find_all_trips_from_user(session[:user_id])
  erb :set_current_trip
end

patch '/set_current_trip' do
  set_current_trip(params[:trip_id], session[:user_id])

  redirect '/home'
end




get '/create_trip' do
  erb :create_trip
end

post '/create_trip' do
  user = find_one_user(session[:user_id])
  # raise @user["id"].to_s
  create_trip(params, user["id"])
  redirect '/home'
end

get '/trip_details' do
erb :trip_details
end

get '/edit_trip' do
  @user = find_one_user(session[:user_id])
  @current_trip = find_current_trip_data(@user["current_trip_id"])

  erb :edit_trip
end


patch '/edit_trip' do
  @user = find_one_user(session[:user_id])
  if params[:id] = @user["current_trip_id"]
    update_trip(params)
  end
  # include remove or add travel buddy here (overall trip info)
  redirect '/home'
end


# get '/delete' do
#   erb :delete
# end

delete '/delete' do
  redirect '/home'
end




# # menu bar

# get '/trip_details' do
# # edit trip daily details only
#   erb :trip_details
# end


# get '/next_day' do

#   erb :trip_details
# end


# get '/calendar_view' do

#   erb :calendar_view
# end






get '/colors_view' do
  erb :colors_view
end
