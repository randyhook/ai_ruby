require_relative 'thing'

class Parser

	def Parser.parse(input)

		words = input.split(' ')

		wordCounter = 0
		for word in words
			case word
				when 'is'
					if (wordCounter < words.length - 1)
						case words[wordCounter + 1]
							when 'a', 'an'
								if (wordCounter > 0 && wordCounter < words.length - 2)
									puts words[wordCounter - 1] + ' is a type of ' + words[wordCounter + 2]
								end	
						end	
					end		
			end

			wordCounter += 1
		end

	end

end
