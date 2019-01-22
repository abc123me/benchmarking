#!/usr/bin/lua

function prime(n)
	if n == 2 then return true end
	if n < 2 then return false end
	if n % 2 == 0 then return false end
	for i=3,(n - 1),2 do
		if n % i == 0 then
			return false
		end
	end
	return true
end
function primes(buf, n)
	if n < 1 then return end
	local j = 1
	local i = 1
	buf[0] = 2
	while i < n do
		if prime(j) then
			buf[i] = j
			i = i + 1
		end
		j = j + 2
	end
end

amount = 1000
benches = 1
if table.getn(arg) > 0 then amount = tonumber(arg[1]) end
if table.getn(arg) > 1 then benches = tonumber(arg[2]) end
buf = {}
times = {}
for b=0, benches do
	start = os.clock()
	primes(buf, amount)
	took = os.clock() - start
	times[b] = math.floor(took * 1000)
end
s = "[Lua] Finding " .. amount .. " primes took "
if benches == 1 then
	s = s .. times[0] .. "ms"
else
	s = s .. "[" .. times[0]
	for i=1, benches - 1 do
		s = s .. ", " .. times[i]
	end
	s = s .. "]"
end
print(s)
