require 'open-uri'
require 'json'

class Knowledge

	BASE_URI = 'http://conceptnet5.media.mit.edu/data/5.1/'
	
	def Knowledge.ask(questionType, concepts)
		case questionType
			when 'is'
				uri = 'search?start=' + concepts[0] + '&rel=/r/IsA&end=' + concepts[1]
			when 'what'
				uri = 'search?start=' + concepts[0] + '&minWeight=1&limit=1'
			else
				uri = nil
		end

		result = nil
		open(Knowledge::BASE_URI + uri) {
			|http|
			result = JSON.parse(http.read)
		}

		case questionType
			when 'is'
				output = result['numFound'] > 0 ? 'Yes, i believe so.' : 'Not that i know of.'
			when 'what'
				if (result['numFound'] == 0)
					output = 'I have no idea.'
				else
					result['edges'].each { |edge|
						output = edge['end']
					}
				end
			else
				output = 'I am confused.'
		end

		puts output 

	end

	def Knowledge.store(frame, property, value)

		#check if this frame/property exists

	end

end
