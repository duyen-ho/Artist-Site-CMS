require_relative '../models/user'


get '/login' do
  @work_types = WorkType.all
  if User.find_by(id: session[:user_id])
    redirect to '/admin/dashboard'
  end

  erb :login
end

post '/login' do
  @work_types = WorkType.all
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/admin/dashboard'
  end

  @message = 'Please enter a valid username and password'
  erb :login
end

delete '/login' do
  session[:user_id] = nil
  redirect to '/login'
end
