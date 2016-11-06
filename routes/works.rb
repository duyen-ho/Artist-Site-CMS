require_relative '../models/work'
require_relative '../models/work_type'
require_relative '../models/biography'
require_relative '../models/contact'


get '/works' do
  @works = Work.all

  @title = params[:category]

  if @title != NIL
    @work_type = @work_types.find_by(name: @title).id
    @works = Work.where(work_type_id: @work_type)
  end

  erb :works_show
end
