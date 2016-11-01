require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'
require_relative 'models/work'
require_relative 'models/work_type'
require_relative 'models/user'

enable :sessions

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end

get '/session/new' do
  erb :session_new
end

post '/session' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/dashboard'
  else
    if !user
      @message = 'Please enter a valid username and password'
      erb :session_new
    end
  end

end

delete '/session' do
  session[:user_id] = nil
  redirect to '/session/new'
end

get '/dashboard' do
  @work_types = WorkType.all
  @works = Work.all
  erb :dashboard
end

get '/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all
  erb :works_edit
end
