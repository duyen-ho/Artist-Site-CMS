require_relative '../models/work'
require_relative '../models/work_type'


get '/search' do
  @work_types = WorkType.all
  search_word = params[:search].downcase
  @works = Work.where('LOWER(title) LIKE ? OR LOWER(medium) LIKE ? OR LOWER(dimensions) LIKE ? OR LOWER(notes) LIKE ?', "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%").all
  erb :search_results
end
