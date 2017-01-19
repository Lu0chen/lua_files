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
