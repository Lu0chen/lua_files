--[[
a = {}
for i = 1,10 do
    a[i] = i
end

for i,line in ipairs(a) do
    print(line)
end

c = a
for i, line in ipairs(c) do
    print (line)
end

print  ("2" < "15")

days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
print (days[0])

list = nil
for line in io.line() do
    list = {next = list, value = line}
end

l = list
while l do
    print (l.value)
    l = l.next
end

a = "hello".."world"
print (a)

network = {
    {name = "grauna",  IP = "210.26.30.34"},
    {name = "arraial", IP = "210.26.30.23"},
    {name = "lua",     IP = "210.26.23.12"},
    {name = "derain",  IP = "210.26.23.20"},
}

table.sort(network, function(a, b)
    return (a.name < b.name)
end)

for l,v in ipairs(network) do
    print (v.name)
end

function eraseTerminal ()
    io.write("")
end

eraseTerminal()

print "enter function to be plotted (with variable `x'):"
local l = io.read()
local f = assert(loadstring("return " .. l))
for i=1,10 do
    x = i   -- global `x' (to be visible from the chunk)
    print(string.rep("*", f()))
end
--]]
function permgen (a, n)
    if n == 0 then
        printResult(a)
    else
        for i=1,n do
            a[n], a[i] = a[i], a[n]                
            permgen(a, n - 1)
            a[n], a[i] = a[i], a[n]
        end 
    end
end --这是一个将传入的字符排列组合的函数


function perm (a)
    local n = table.getn(a)
    return coroutine.wrap(function () permgen(a, n) end)
end
for p in perm{"a", "b", "c"} do
    printResult(p)
end


