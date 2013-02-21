function coFib()
	local one = 0
	local two = 1
	coroutine.yield(one)
	coroutine.yield(two)

	while true do
		local sum = one + two
		one = two
		two = sum
		coroutine.yield(sum)
	end
end


--main

local fib = coroutine.wrap(coFib)

local i = 0
while i < 100 do
	i = i + 1
	print(i.." : "..fib())
end



