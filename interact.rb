require_relative 'parser'

class Interact

	@@currentInput = nil

	def Interact.askForInput
		puts 'What can I do for you?'
	end

	def Interact.getInput
		@@currentInput = gets.strip
		Parser.parse(@@currentInput)
	end

end
