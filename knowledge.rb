require 'open-uri'
require 'json'

class Knowledge

	BASE_URI = 'http://conceptnet5.media.mit.edu/data/5.1/'
	
	def Knowledge.ask(concepts)
		result = nil

		open(Knowledge::BASE_URI + 'search?start=' + concepts[0] + '&rel=/r/IsA&end=' + concepts[1]) {
			|http|
			result = JSON.parse(http.read)
		}

		puts result['numFound'] > 0 ? 'yes, i believe so' : 'not that i know of'

	end

	def Knowledge.store(frame, property, value)

		#check if this frame/property exists

	end

end
