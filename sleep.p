# Set the output to a png file
set terminal png size 500,500
# The file we'll write to
set output 'sleep.png'
# The graphic title
set title 'Sleep AHI History'
set xlabel "Date"
set ylabel "AHI"
plot "sleep.dat" using 1:2 with lines
