//start with a clear
clear
//fucntion 


//input

// output

//draw plot
x = -4:0.005:4
R = ((cos(x)+1/4).^2 - (sin(x).^2-79/16)) ./(0.2*((6 + 0.5*cos(x)).^2 - 19.75*sin(x).^2))
I = (2*sin(x).*(cos(x)+0.25)) ./ (0.2*((6 + 0.5*cos(x)).^2 - 19.75*sin(x).^2))
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
