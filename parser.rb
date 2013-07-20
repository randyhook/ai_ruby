require_relative 'knowledge'

class Parser

	@@sentenceTypes = { 
		:statement => 'statement',
		:question => 'question',
		:unknown => 'unknown'
	}

	@@ignoreWords = ['is', 'a', 'an', 'the'];

	#the sentence type of the sentence the parser is working on
	@@sentenceType = nil
	#the array of words the parser is working on
	@@words = nil
	
	def Parser.parse(input)

		if (input == 'goodbye')
			return input
		end

		@@words = input.split(' ')
		wordCounter = 0
		
		@@sentenceType = Parser.setSentenceType()
		
		case @@sentenceType
			when @@sentenceTypes[:question]
				Knowledge.ask(Parser.parseQuestion())
			else
				for w in @@words
					currentWord = Parser.getWord(wordCounter)

					case currentWord.downcase
						when 'is'
							Parser.parseIs(wordCounter)
					end

					wordCounter += 1
				end
		end

		return input
	end

	def Parser.setSentenceType()
		lastWord = @@words.last

		case lastWord[lastWord.length - 1]
			when '?'
				@@sentenceType = @@sentenceTypes[:question]
			else
				@@sentenceType = @@sentenceTypes[:unknown]	
		end
	end

	def Parser.parseQuestion()
		concepts = Array.new

		for word in @@words
			word.chomp!('?')
			unless (@@ignoreWords.include?(word))
				concepts.push(word)
			end
		end

		return concepts
	end

	def Parser.parseIs(wordPos)
		nextWord = getNextWords(wordPos, 1)

		case nextWord.join.downcase 
			when 'a', 'an'
				source = getPreviousWords(wordPos, 1)
				target = getNextWords(wordPos + 1, 1) 

				unless (source.empty? || target.empty?)
					puts 'You are saying that ' + source[0] + ' is a type of ' + target[0] + '?'
					answer = gets.strip.downcase
					
					if (answer == 'y' || answer == 'yes')
						Knowledge.store(source, 'is a', target)
					else
						puts 'OK, I will disregard that then'
					end
				else
					puts 'Something went wrong'
				end	
		end	
	end

	def Parser.getWord(wordPos)
		if (wordPos < 0 || wordPos >= @@words.length)
			return nil
		else
			return @@words[wordPos]
		end
	end

	#currentPos: the word to get words previous to
	#wordCount: how many words to get
	#
	#return: array of strings
	def Parser.getPreviousWords(currentPos, wordCount)
		snippet = Array.new
		wordCounter = 0
		currentWordPos = currentPos - 1

		until wordCounter == wordCount || currentWordPos == -1
			snippet.push(@@words[currentWordPos])
			wordCounter += 1
			currentWordPos -= 1
		end
		
		return snippet
	end

	#currentPos: the word to get words after
	#wordCount: how many words to get
	#
	#return: array of strings
	def Parser.getNextWords(currentPos, wordCount)
		snippet = Array.new
		wordCounter = 0
		currentWordPos = currentPos + 1
		
		until wordCounter == wordCount || currentWordPos >= @@words.length 
			snippet.push(@@words[currentWordPos])
			wordCounter += 1
			currentWordPos += 1
		end

		return snippet
	end

end
