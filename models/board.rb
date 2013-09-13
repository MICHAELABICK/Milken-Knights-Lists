class Board  
	include DataMapper::Resource  
	property :id, Serial  
	property :name, Text, :required => true
	
	has n, :task
end