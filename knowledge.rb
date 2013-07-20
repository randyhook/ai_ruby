require 'open-uri'
require 'json'

class Knowledge

	BASE_URI = 'http://conceptnet5.media.mit.edu/data/5.1/'
	
	def Knowledge.ask(questionType, sources, targets, limit = 1)
		sourceString = sources.join(',');
		targetString = targets.join(',');

		case questionType
			when 'is'
				uri = 'search?startLemmas=' + sourceString + '&rel=/r/IsA&endLemmas=' + targetString
			when 'what'
				uri = 'search?startLemmas=' + sourceString + '&rel=/r/IsA&minWeight=1&limit=' + limit.to_s()
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
					output = ''
					edgeCounter = 0
					result['edges'].each { |edge|
						if (edgeCounter > 0)
							output += " or\n"
						end

						output += edge['startLemmas']
						
						edgeCounter += 1
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
