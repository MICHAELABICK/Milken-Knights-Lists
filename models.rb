require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/tasks.db")

require './models/task'

DataMapper.finalize.auto_upgrade!