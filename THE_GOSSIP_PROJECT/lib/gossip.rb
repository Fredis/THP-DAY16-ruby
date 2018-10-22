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

	def update(id, gossip_content)
		@id = id
		updated_array = []
		count = 1
		CSV.read("./db/gossip.csv").each do |csv_line|
			gossip_hash = {}
			gossip_hash[:author] = csv_line[0]
			if count == @id.to_i
				gossip_hash[:gossip] = gossip_content
			else
				gossip_hash[:gossip] = csv_line[1]
			end
			updated_array << gossip_hash
			count += 1
		end

		CSV.open("./db/gossip.csv", "w+") do |csv|
			updated_array.each do |element|
			csv << [element[:author], element[:gossip]]
			end
				
		end

	end

end