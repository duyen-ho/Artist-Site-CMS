require 'active_record'

options = {
  adapter: 'postresql',
  database: 'miasalsjo'
}

ActiveRecord::Base.establish_connection(options)
