i={}
		function i:S() print(1) end
		local olds=i.S
		function i:S()
			olds()
			print(2)
		end
		i:S()