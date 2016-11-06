require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'


before do

  @work_types = WorkType.all

end


require_relative 'routes/index'
require_relative 'routes/login'
require_relative 'routes/dashboard'
require_relative 'routes/search'
require_relative 'routes/biography'
require_relative 'routes/contact'
require_relative 'routes/works'


enable :sessions

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
