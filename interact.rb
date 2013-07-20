require_relative 'parser'

class Interact

	@@numberOfGreetings = 0
	@@currentInput = nil

	def Interact.askForInput
		if (@@numberOfGreetings == 0)
			puts "\n" + 'Hi there! How may I be of service?'
			@@numberOfGreetings += 1
		else
			puts "\n" + 'Anything else?'
		end

		@@currentInput = gets.strip
		return Parser.parse(@@currentInput)
	end

end
