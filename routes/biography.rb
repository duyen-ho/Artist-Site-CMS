require_relative '../models/biography'


get '/biography' do
  @bio = Biography.last
  erb :bio_show
end
