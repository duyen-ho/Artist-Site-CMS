to filter categories
Work.where('work_type_id = ?', params[:work_type_id])
Work.where(work_type_id: (1))

to print name of category
[17] pry(main)> @work = WorkType.find(@work.work_type_id).name
=> "Drawings"

Search
Table.where('keywords LIKE ?', '%crescent%').all





MAIN.RB at login broken

require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'
require_relative 'models/work'
require_relative 'models/work_type'
require_relative 'models/user'
require_relative 'models/biography'
require_relative 'models/contact'

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
  # binding.pry

  erb :session_new

  if logged_in?
    @work_types = WorkType.all
    redirect to '/admin/dashboard'
  end

end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/admin/dashboard'
  else
    @message = 'Please enter a valid username and password'
    erb :session_new
  end

end

delete '/session' do
  session[:user_id] = nil
  redirect to '/login'
end

get '/admin/dashboard' do
  @work_types = WorkType.all
  @works = Work.all
  # @works = @works.desc
  erb :dashboard
end

get '/admin/dashboard/works/new' do
  @work = Work.new
  @work_types = WorkType.all
  erb :works_new
end

post '/admin/dashboard/works/new' do
  @work = Work.new
  @work_types = WorkType.all

  @work.title = params[:title]
  @work.work_type_id = params[:work_type_id]
  @work.medium = params[:medium]
  @work.dimensions = params[:dimensions]
  @work.image_url = params[:image_url]
  @work.video_url = params[:video_url]
  @work.display_homepage = params[:display_homepage]
  @work.notes = params[:notes]

  if @work.save
    redirect to '/admin/dashboard'
  else
    @status = 'There was an error saving. Please check your entry.'
  end

  erb :works_new
end

get '/admin/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all
  erb :works_edit
end

post '/admin/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])
  @work_types = WorkType.all

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
  # are you sure?
  erb :delete
end

delete '/admin/dashboard/:id/delete' do
  work = Work.find(params[:id])
  work.delete
  redirect to '/admin/dashboard'
end

get '/admin/dashboard/biography/edit' do
  @bio = Biography.last
  @work_types = WorkType.all
  erb :bio_edit
end

post '/admin/dashboard/biography/edit' do
  @work_types = WorkType.all
  bio = Biography.last
  bio.body = params[:body]
  bio.save

  if bio.save
    @status = 'Changes saved'
  else
    @status = ''
  end

  erb :bio_edit
end

get '/admin/dashboard/contact/edit' do
  "Hello World"
end

get '/admin/dashboard/works' do
  @work_types = WorkType.all
  @title = params[:category]
  work_type = @work_types.find_by(name: @title).id
  @works = Work.where(work_type_id: work_type)
  erb :works_submenu
end
#
# get '/search' do
#   @work_types = WorkType.all
#   search_word = params[:search].downcase
#   @works = Work.where('lower(title) LIKE ? OR lower(medium) LIKE ? OR lower(dimensions) LIKE ? OR lower(notes) LIKE ?', "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%").all
#   # binding.pry
#   erb :search_results
# end

# Visitor routes
get '/' do
  erb :index
end

get '/works' do

  erb :works
end



LAYOUT.erb

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Mia Cera Salsjo Artist</title>
  <meta name="description" content="Mia Salsjo Contemporary Australian Artist Installation Art Silkscreen Drawing Video Art">
  <link rel='stylesheet' href='/stylesheets/main.css'>
  <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
  <script type="text/javascript">
    tinymce.init({
    selector: '.rtf_edit',
    skin: 'lightgray',
    plugins: 'link',
    menubar: false,
    toolbar: 'undo redo | bold italic underline | link',
    width: 600,
    height : 500,
  });
  </script>
</head>

<body>

  <%#<form class="search-bar" action="/search" method="get">
    <input name="search" type="text" value="" size="60">
    <button id="search-btn">Search</button>
  </form>%>

  <h1>Mia Salsjo</h1>

  <% if logged_in? %>

  <p>Welcome <%= User.find(session[:user_id]).name %></p>

  <form action="/session" method="post">
    <input type="hidden" name="_method" value="delete">
    <button>Log Out</button>
  </form>

  <nav>
    <h2>Edit</h2>
    <ul>
      <li class="menu-main"><a href="/admin/dashboard">Works</a></li>
      <li class="menu-main"><a href="/admin/dashboard/biography/edit">Biography</a></li>
      <li class="menu-main"><a href="/admin/dashboard/contact/edit">Contact</a></li>
    </ul>
    <ul class="menu-sub">
      <% @work_types.each do |category| %>
      <li><a href="/admin/dashboard/works?category=<%= category.name %>"><%= category.name %></a></li>
      <% end %>
    </ul>
    <a href="/admin/dashboard/works/new">Add New Work</a>
  </nav>

  <% end %>

  <%= yield %>

</body>
</html>
