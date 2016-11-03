require_relative '../models/work'
require_relative '../models/work_type'
require_relative '../models/biography'
require_relative '../models/contact'

get '/admin/dashboard' do
  @work_types = WorkType.all
  @works = Work.all
  # @works = @works.desc
  erb :dashboard
end
#
# get '/admin/dashboard/works/new' do
#   @work = Work.new
#   @work_types = WorkType.all
#   erb :works_new
# end
#
# post '/admin/dashboard/works/new' do
#   @work = Work.new
#   @work_types = WorkType.all
#
#   @work.title = params[:title]
#   @work.work_type_id = params[:work_type_id]
#   @work.medium = params[:medium]
#   @work.dimensions = params[:dimensions]
#   @work.image_url = params[:image_url]
#   @work.video_url = params[:video_url]
#   @work.display_homepage = params[:display_homepage]
#   @work.notes = params[:notes]
#
#   if @work.save
#     redirect to '/admin/dashboard'
#   else
#     @status = 'There was an error saving. Please check your entry.'
#   end
#
#   erb :works_new
# end
#
# get '/admin/dashboard/works/:id/edit' do
#   @work = Work.find(params[:id])
#   @work_types = WorkType.all
#   erb :works_edit
# end
#
# post '/admin/dashboard/works/:id/edit' do
#   @work = Work.find(params[:id])
#   @work_types = WorkType.all
#
#   @work.title = params[:title]
#   @work.work_type_id = params[:work_type_id]
#   @work.medium = params[:medium]
#   @work.dimensions = params[:dimensions]
#   @work.image_url = params[:image_url]
#   @work.video_url = params[:video_url]
#   @work.display_homepage = params[:display_homepage]
#   @work.notes = params[:notes]
#
#   if @work.save
#     @status = 'Changes saved'
#   else
#     @status = ''
#   end
#
#   erb :works_edit
# end
#
# post '/admin/dashboard/:id/delete' do
#   @work = Work.find(params[:id])
#   @work_types = WorkType.all
#   # are you sure?
#   erb :delete
# end
#
# delete '/admin/dashboard/:id/delete' do
#   work = Work.find(params[:id])
#   work.delete
#   redirect to '/admin/dashboard'
# end
#
# get '/admin/dashboard/biography/edit' do
#   @bio = Biography.last
#   @work_types = WorkType.all
#   erb :bio_edit
# end
#
# post '/admin/dashboard/biography/edit' do
#   @work_types = WorkType.all
#   bio = Biography.last
#   bio.body = params[:body]
#   bio.save
#
#   if bio.save
#     @status = 'Changes saved'
#   else
#     @status = ''
#   end
#
#   erb :bio_edit
# end
#
# get '/admin/dashboard/contact/edit' do
#   "Hello World"
# end
#
# get '/admin/dashboard/works' do
#   @work_types = WorkType.all
#   @title = params[:category]
#   work_type = @work_types.find_by(name: @title).id
#   @works = Work.where(work_type_id: work_type)
#   erb :works_submenu
# end
#
