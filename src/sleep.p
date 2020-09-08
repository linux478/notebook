set terminal png size 500,500
set output 'out/sleep.png'
set title 'Sleep AHI History'
set grid
set xdata time
set timefmt "%Y%m%d"
set xrange ["20200907":"20200908"]
set yrange ["2":"3"]
set format x "%m/%d"
set xtics format "%b %d"
set xtics "20200907", 86400 , "20201001"
set xlabel "Date"
set ylabel "AHI"
plot "src/sleep.dat" using 1:2 with lines
