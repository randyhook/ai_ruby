require_relative 'knowledge'

class Parser

	@@words = nil
	
	def Parser.parse(input)

		@@words = input.split(' ')
		wordCounter = 0
		
		for w in @@words
			currentWord = Parser.getWord(wordCounter);

			case currentWord.downcase
				when 'is'
					Parser.parseIs(wordCounter)
			end

			wordCounter += 1
		end

	end

	def Parser.parseIs(wordPos)
		if (wordPos < @@words.length - 1)
			nextWord = getNextWords(wordPos + 1, 1)

			case nextWord.join.downcase 
				when 'a', 'an'
					source = getPreviousWords(wordPos - 1, 1)
					target = getNextWords(wordPos + 2, 1) 

					unless (source.empty? || target.empty?)
						puts 'You are saying that ' + source[0] + ' is a type of ' + target[0] + '?'
						answer = gets.strip.downcase
						
						if (answer == 'y' || answer == 'yes')
							Knowledge.store(source, 'is a', target);
						else
							puts 'OK, I will disregard that then'
						end
					else
						puts 'Something went wrong'
					end	
			end	
		end		
	end

	def Parser.getWord(wordPos)
		return @@words[wordPos]
	end

	def Parser.getPreviousWords(startPos, wordCount)
		snippet = Array.new
		wordCounter = 0
		currentWordPos = startPos

		until wordCounter == wordCount || currentWordPos == -1
			snippet.push(@@words[currentWordPos])
			wordCounter += 1
			currentWordPos -= 1
		end
		
		return snippet
	end

	def Parser.getNextWords(startPos, wordCount)
		snippet = Array.new
		wordCounter = 0
		currentWordPos = startPos
		
		until wordCounter == wordCount || currentWordPos >= @@words.length 
			snippet.push(@@words[currentWordPos])
			wordCounter += 1
			currentWordPos += 1
		end

		return snippet
	end

end
