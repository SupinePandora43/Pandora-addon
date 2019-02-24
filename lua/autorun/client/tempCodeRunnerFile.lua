tbl = {"sui.vmt", "sent.vmt"}
	for k,v in pairs(tbl) do
		print(k,v)
		print(string.sub( "sp/s/" .. v, 1, #("sp/s/"..v) - 4))
	end