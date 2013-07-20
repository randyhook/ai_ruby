require 'open-uri'

class Knowledge

	BASE_URI = 'http://conceptnet5.media.mit.edu/data/5.1/'
	
	def Knowledge.ask(concepts)
		for concept in concepts
			open(Knowledge::BASE_URI << 'c/en/' << concept) {
				|http|
				puts http.read
			}
		end
	end

	def Knowledge.store(frame, property, value)

		#check if this frame/property exists

	end

end
