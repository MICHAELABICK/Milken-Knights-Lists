class Task  
	include DataMapper::Resource  
	property :id, Serial  
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :description, Text
	property :created_at, DateTime  
	property :updated_at, DateTime
	
	belongs_to :board, :required => false
	has 1, :priority
end
	
class Priority
	include DataMapper::Resource 
	property :id, Serial
	property :level, Text, :required => true
	property :color, Text
	
	belongs_to :task, :required => false
end