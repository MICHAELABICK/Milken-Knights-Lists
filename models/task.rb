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
	
	belongs_to :board, :required => false
end