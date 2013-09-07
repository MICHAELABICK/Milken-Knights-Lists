# tasks.rb

require 'sinatra'  
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/tasks.db")  
  
class Note  
	include DataMapper::Resource  
	property :id, Serial  
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false  
	property :created_at, DateTime  
	property :updated_at, DateTime
end
  
DataMapper.finalize.auto_upgrade!

get '/' do
  @notes = Note.all :order =>:id.desc
  @title = 'Dashboard'
  erb :dashboard
end

post '/' do  
  n = Note.new  
  n.content = params[:content] 
  n.created_at = Time.now  
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end 

get '/:id' do  
  @note = Note.get params[:id]  
  @title = "Task ##{params[:id]}"  
  erb :edit  
end

put '/:id' do  
  n = Note.get params[:id]  
  n.content = params[:content]  
  n.complete = params[:complete] ? 1 : 0  
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end

get '/:id/delete' do  
  @note = Note.get params[:id]  
  @title = "Delete task ##{params[:id]}"  
  erb :delete  
end

delete '/:id' do  
  n = Note.get params[:id]  
  n.destroy  
  redirect '/'  
end 