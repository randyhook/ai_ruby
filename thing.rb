class Thing
	def initialize(parts)
		if parts.join
			@name = parts[0]
			@parent = parts[1]
		else
			@name = parts
		end

	end

	def getParent()
		puts 'parent is: ' + @parent
	end
end
