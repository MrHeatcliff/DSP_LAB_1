//start with a clear
clear
//fucntion 


//input

// output

//draw plot
x = -4:0.01:4
y = 1 ./ sqrt(1-2*0.1*cos(x)+0.1^2)
f0 = scf(0);
plot2d(x, y)
title("Amplitude spectrum")
xlabel("W")
ylabel("|X(W)|")
f1 = scf(1);
y = atan(-0.1*sin(x) ./ (1-0.1*cos(x)))
plot2d(x, y)
title("Phase spectrum")
xlabel("W")
ylabel("angle(X(W)|)")
f2 = scf(2);
y = sqrt ((1 + cos(x) + cos(2*x) + cos(3*x)) .^ 2 + (sin(x) + sin(2*x) + sin(3*x)) .^ 2)
plot2d(x, y)
title("Amplitude spectrum")
xlabel("W")
ylabel("|X(W)|")
f3 = scf(3);
y = atan(-1*(sin(x) + sin(2*x) + sin(3*x)) ./ (1 + cos(x) + cos(2*x) + cos(3*x)))
plot2d(x, y)
title("Phase spectrum")
xlabel("W")
ylabel("angle(X(W)|)")
