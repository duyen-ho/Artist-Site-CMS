require_relative '../models/biography'


get '/admin/dashboard' do
  @works = Work.all
  # @works = @works.desc
  erb :dashboard
end

get '/admin/dashboard/works/new' do
  @work = Work.new
  erb :works_new
end

post '/admin/dashboard/works/new' do
  @work = Work.new

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
  erb :works_edit
end

post '/admin/dashboard/works/:id/edit' do
  @work = Work.find(params[:id])

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

  erb :bio_edit
end

post '/admin/dashboard/biography/edit' do
  @bio = Biography.last
  @bio.body = params[:body]
  @bio.save

  if @bio.save
    @status = 'Changes saved'
  else
    @status = ''
  end

  erb :bio_edit
end

get '/admin/dashboard/contact/edit' do
  @mia = User.first
  erb :contact_edit
end

post '/admin/dashboard/contact/edit' do
  @mia = User.first

  @mia.email = params[:email]
  @mia.save

  if @mia.save
    @status = 'Changes saved'
  else
    @status = ''
  end
  erb :contact_edit
end

get '/admin/dashboard/works' do
  @title = params[:category]
  work_type = @work_types.find_by(name: @title).id
  @works = Work.where(work_type_id: work_type)
  erb :works_submenu
end
