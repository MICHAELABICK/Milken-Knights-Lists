# tasks.rb

require 'sinatra'

require './models' 

prototyping = Board.first_or_create(:name => 'Prototyping')
design = Board.first_or_create(:name => 'Design')
electrical = Board.first_or_create(:name => 'Electrical')
programming = Board.first_or_create(:name => 'Programming')
business = Board.first_or_create(:name => 'Business')

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

get '/boards' do
	@boards = Board.all :order => :id.desc
	@title = 'Boards'
	erb :boards
end

post '/boards' do  
	board = Board.new
	board.name = params[:name]
	board.save
	redirect '/boards'  
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