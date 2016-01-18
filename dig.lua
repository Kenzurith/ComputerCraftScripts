local args = { ... }
if #args ~= 3 then
	print("Usage: dig x y z")
end

local x = tonumber(args[1])
local y = tonumber(args[2])
local z = tonumber(args[3])

local left = true
local bottom = true

j = 1
for i = 1, z do
	turtle.dig()
	turtle.forward()
	if x > 1 then
		while true do
			if left then
				turtle.turnRight()
			else
				turtle.turnLeft()
			end
			for k = 1, x - 1 do
				turtle.dig()
				if(j < y) then
					if bottom then
						turtle.digUp()
					else
						turtle.digDown()
					end
				end
				if(j > 1) then
					if bottom then
						turtle.digDown()
					else
						turtle.digUp()
					end
				end
				turtle.forward()
			end
			left = not left
			if left then
				turtle.turnRight()
			else
				turtle.turnLeft()
			end
			if j > 1 then
				if bottom then
					turtle.digDown()
				else
					turtle.digUp()
				end
			end
			if j >= y - 1 then break end
			for l = 1, 3 do
				if y - j > 1 then
					if bottom then
						turtle.digUp()
						turtle.up()
					else
						turtle.digDown()
						turtle.down()
					end
					j = j + 1
				end
			end
		end
	else
		while j < y - 1 do
			if bottom then
				turtle.digUp()
				turtle.up()
			else
				turtle.digDown()
				turtle.down()
			end
			j = j + 1
		end
		if(j > 1) then
			if bottom then
				turtle.digDown()
			else
				turtle.digUp()
			end
		end
	end
	if y ~= 1 then
		if bottom then
			turtle.digUp()
		else
			turtle.digDown()
		end
	end
	bottom = not bottom
	j = y - j + 1
end
