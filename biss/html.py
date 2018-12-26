
import numpy as np
import sys

courses = []

with open('file.txt') as ff:
	for line in ff:
		if ':' in line.lower():
			nums = line.split(":")[1].strip()
			num_arr = nums.split(" ")
			courses.append(num_arr)
			# print num_arr

print courses
a = np.array(courses)
courses = a.transpose()
print courses

# sys.exit()

course1 = "<td style='text-align: center; background-color: rgb(231, 213, 143);'>ML</td>"
course2 = "<td style='text-align: center; background-color: rgb(200, 184, 124);'>SS</td>"
course3 = "<td style='text-align: center; background-color: rgb(195, 156, 78);'>IoT</td>"
courseDef = "<th style='text-align: center;' bgcolor='#676767;'><font color='white'>-<br /> "
coursebreak = "<th colspan='5' align='center' bgcolor='#c57b60'><i><font color='white'>coffee break</font></i></th>"
courseArrival = "<th style='text-align: center;' rowspan='2' bgcolor='#4754a3'><i><font color='white'>arrival</font></i></th>"

ths = [
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>09.00-10.00</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>10.00-11.00</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>11.30-12.30</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>12.30-13.30</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>15.00-16.00</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>16.00-17.00</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>17.00-17.30</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>17.30-18.30</font></th>",
	"<th style='text-align: center;' bgcolor='#676767'><font color='white'>18.30-19.30</font></th>",
]
html = ""
for idx,row in enumerate(courses):
	if idx == 2:
		html = html + "<tr>"+"<th style='text-align: center;' bgcolor='#676767'><font color='white'>11.00-11.30</font></th>" + coursebreak+ "</tr>"
	elif idx == 4:
		html = html+"<tr>" +"<th style='text-align: center;' bgcolor='#676767'><font color='white'>13.30-15.00</font></th> <th colspan='5' align='center' bgcolor='#c57b60'><i><font color='white'>lunch</font></i></th> </tr>"
	elif idx == 6:
		html =html+ "<tr>" +"<th style='text-align: center;' bgcolor='#676767'><font color='white'>17.00-17.30</font></th>"+coursebreak+ "</tr>"
		

	html = html + "<tr>"
	html = html + ths[idx]

	if idx == 6:
		html += "<th style='text-align: center;'' rowspan='2' bgcolor='#4754a3'><i><font color='white'>arrival</font></i></th>"

	for course in row:
		tmp = '<th style="text-align: center;" bgcolor="#676767;"><font color="white">-</font><br /> '
		if course == '1':
			tmp = course1
		elif course == '2':
			tmp = course2
		elif course == '3':
			tmp = course3
		elif course == '0' and idx == 4:
			tmp = '<th style="text-align: center;" bgcolor="#676767;"><font color="white">departure</font><br /> '

		html += tmp

	# if idx == 7:
	# 	html += "<th style='text-align: center;' bgcolor='#676767;'><font color='white'>departure<br /></font></th>"


	html =  html + '</tr>'

	
		
print html





