require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'miasalsjo'
}

ActiveRecord::Base.establish_connection(options)
