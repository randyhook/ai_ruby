require_relative 'parser'

class Interact

	@@currentInput = nil

	def Interact.askForInput
		puts 'How may I be of service?'

		@@currentInput = gets.strip
		return Parser.parse(@@currentInput)
	end

end
