n = 10
m = 10
for f in range(0,n):
	for c in range(0,m):
		if f == 0:
			print "(%d,%d) = [8,0]"%(f,c)
			continue
		if f == n-1:
			print "(%d,%d) = [16,0]"%(f,c)
			continue
		if c == 1:
			print "(%d,%d) = [2,-1]"%(f,c)
			continue
		print "(%d,%d) = [0,-1]"%(f,c)
print ""