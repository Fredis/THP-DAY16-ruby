class Comment
	
	attr_accessor :id_gossip, :comment

	def initialize(id_gossip, comment)
		@id_gossip = id_gossip
		@comment = comment
	end

	def new_comment
		CSV.open("./db/comment.csv", "ab") do |csv|
			csv << [@id_gossip, @comment]
		end
	end

	def read
		array = []
		count = 1
		CSV.read("./db/comment.csv").each do |csv_line|
			if count == @id.to_i
				array << csv_line[0]
				array << csv_line[1]
			end
			count += 1
		end
		return array

	end

end