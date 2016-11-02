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

get '/login' do
  @work_types = WorkType.all
  erb :session_new
end

post '/login' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/admin/dashboard'
  else
    if !user
      @message = 'Please enter a valid username and password'
      erb :session_new
    end
  end

end

delete '/session' do
  session[:user_id] = nil
  redirect to '/login'
end

get '/admin/dashboard' do
  # binding.pry
  @work_types = WorkType.all
  @works = Work.all
  erb :dashboard
end

get '/admin/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all
  erb :works_edit
end

post '/admin/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all
  # save changes
  @work.title = params[:title]
  @work.work_type_id = params[:work_type_id]
  @work.medium = params[:medium]
  @work.dimensions = params[:dimensions]
  @work.image_url = params[:image_url]
  @work.video_url = params[:video_url]
  @work.display_homepage = params[:display_homepage]
  @work.notes = params[:notes]

  if @work.save
    @status = 'Changes saved'
  else
    @status = ''
  end

  erb :works_edit
end

post '/admin/dashboard/:id/delete' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all
  # validate - are you sure?
  erb :delete
end

delete '/admin/dashboard/:id/delete' do
  work = Work.find(params[:id])
  work.delete
  redirect to '/admin/dashboard'
end
