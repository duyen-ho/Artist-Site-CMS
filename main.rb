require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'
require_relative 'routes/index'
require_relative 'routes/login'
require_relative 'routes/dashboard'


enable :sessions

helpers do

  def logged_in?
    !!current_user
    # binding.pry
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end

# get '/search' do
#   @work_types = WorkType.all
#   search_word = params[:search].downcase
#   @works = Work.where('lower(title) LIKE ? OR lower(medium) LIKE ? OR lower(dimensions) LIKE ? OR lower(notes) LIKE ?', "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%").all
#   # binding.pry
#   erb :search_results
# end
