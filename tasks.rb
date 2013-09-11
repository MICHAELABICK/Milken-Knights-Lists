# tasks.rb

require 'sinatra'  
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/tasks.db")  
  
class Task  
	include DataMapper::Resource  
	property :id, Serial  
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :priority, Text
	property :subdivision, Text, :required => true
	property :description, Text
	property :created_at, DateTime  
	property :updated_at, DateTime
end
  
DataMapper.finalize.auto_upgrade!

get '/' do
	@tasks = Task.all :order => :id.desc
	@title = 'Dashboard'
	erb :dashboard
end

post '/' do  
  task = Task.new  
  task.content = params[:content]
  task.priority = ''
  task.subdivision = params[:subdivision]
  task.description = ''
  task.created_at = Time.now
  task.updated_at = Time.now  
  task.save  
  redirect '/'  
end 

get '/:id' do  
  @task = Task.get params[:id]  
  @title = "#{@task.content}"  
  erb :edit
end

put '/:id' do  
  task = Task.get params[:id]  
  task.content = params[:content]  
  task.complete = params[:complete] ? 1 : 0
  task.description = params[:description] 
  task.updated_at = Time.now  
  task.save  
  redirect '/'  
end

get '/:id/delete' do  
  @task = Task.get params[:id]  
  @title = "#{@task.content}"  
  erb :delete  
end

delete '/:id' do  
  task = Task.get params[:id]  
  task.destroy  
  redirect '/'  
end 

get '/:id/complete' do  
  task = Task.get params[:id]  
  task.complete = task.complete ? 0 : 1 # flip it  
  task.updated_at = Time.now  
  task.save  
  redirect '/'  
end