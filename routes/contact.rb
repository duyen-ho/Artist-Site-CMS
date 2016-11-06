require_relative '../models/contact'


get '/contact' do
  erb :contact_show
end

post '/contact' do
  erb :mailing_list
end
