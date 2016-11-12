require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'miasalsjo'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
