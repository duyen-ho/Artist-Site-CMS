require_relative '../models/work'
require_relative '../models/work_type'
require_relative '../models/biography'
require_relative '../models/contact'


get '/' do
  @works = Work.where(display_homepage: 'true')
  erb :index
end
