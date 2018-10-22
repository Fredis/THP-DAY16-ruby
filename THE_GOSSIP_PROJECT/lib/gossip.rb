class Gossip

	attr_accessor :author, :content, :id

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def find(id)
		@id = id
		array = []
		count = 1
		CSV.read("./db/gossip.csv").each do |csv_line|
			if count == @id.to_i
				array << csv_line[0]
				array << csv_line[1]
			end
			count += 1
		end
		return array
	end

end