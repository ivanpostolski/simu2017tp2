import sys

if __name__ == '__main__':
	log = open("full-log.out","r")
	d = {}
	for l in log:
		step = int(l.split(" ")[6].split(":")[3])
		if (step not in d):
			d[step] = [l]
		else:
			d[step].append(l)
	
	for i in range(0,150):
		for l in d[i]:
			print str(l),
