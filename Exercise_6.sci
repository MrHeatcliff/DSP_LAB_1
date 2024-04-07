//start a file with
clear

//input
n = -1:4
x1 = [0 0 1 3 -2 0]
x2 = [0 1 2 3 0 0]
// some functions for tasks

//condition for input

//calculate
y = x1 + x2
//output
//print all
disp("x1 =")
disp(x1)
disp("x2 =")
disp(x2)
disp("y = x1 + x2 =")
disp(y)
// plot x1
f0 = scf(0)
clf 
plot2d3(n, x1, nax = [0,length(n),0,max(x1) - min(x1)+1])
xgrid(color("grey75"), 1, 7)
xlabel n fontsize 4.5 color red
title x1(n) fontsize 5 color blue
//plot x2
f1 = scf(1)
clf 
plot2d3(n, x2, nax = [0,length(n),0,max(x2)+1])
xgrid(color("grey75"), 1, 7)
xlabel n fontsize 4.5 color red
title x2(n) fontsize 5 color blue
//plot y
f2 = scf(2)
clf 
plot2d3(n, y, nax = [0,length(n),0,max(y) - min(y)+1])
xgrid(color("grey75"), 1, 7)
xlabel n fontsize 4.5 color red
ylabel y(n) fontsize 4.5 color blue
title 'y(n) = x1(n) + x2(n)' fontsize 5 color blue
