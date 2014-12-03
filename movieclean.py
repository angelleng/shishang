import re
import os
f = open('ratings.dat', 'r')
output=file('step1.txt','w')

l = list()
i = 0

for line in f:
	m = re.findall(r'\d*?(?=::)', line)
	if len(m) != 0:
		# #print type(m)
		# m = list(m[0])
		print m
		i = i + 1
		l.append(m[0])
		l.append(m[2])
		l.append(m[4])
		print l
		print type(l[i-1])
		print len(l)
		if i == 5:
			break

	else:
		invalid_output.write(line)	

for j in range(i):
	for k in range(3):
		output.write(l[j * 3 + k] + '\t')
	output.write('\n')

