//start with a clear
clear
//fucntion 


//input

// output

//draw plot
x = -4:0.005:4
R = -2 + 3*(1-0.5*cos(x)) ./(1-cos(x) + 0.5^2)
I = 0.5*sin(x) ./ (1-cos(x)+0.5^2)
y = sqrt(R .^(2) + I .^(2))
f0 = scf(0);
plot2d(x, y)
title("Amplitude spectrum")
xlabel("W")
ylabel("|X(W)|")
f1 = scf(1);
y = atan(I ./ R)
plot2d(x, y)
title("Phase spectrum")
xlabel("W")
ylabel("angle(X(W)|)")
