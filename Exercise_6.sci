//start a file with
clear
//input
xn = [1 2 3 1]
xorigin = 4
hn = [1 2 1 -1]
horigin = 4
// some functions for tasks
function [yn, yorigin] = convolution (xn, xorigin, hn, horigin)
    yn = convol(xn, hn)
    yorigin = xorigin + horigin - 1
endfunction

function draw_plot(xn, xorigin , _color)
    n = 1:size(xn,"c")
    x = n - xorigin    
    y = xn
    
    plot2d(x, y, -1)
    af = gca()
    af.x_location = "origin"
    af.y_location = "origin"
    // configure polyline property 
    p = af.children(1).children(1)
    p.polyline_style = 3
    p.foreground = color(_color)
    p.mark_style = 9
    p.mark_offset = 1
    p.mark_stride = 2
    p.mark_foreground = color(_color)
    p.mark_background = color(_color)
endfunction
//calculate and draw plots
[yn, yorigin] = convolution (xn, xorigin, hn, horigin)
// display
disp("xorigin = " + string(xorigin));
disp("xn = [" + strcat((string(xn)), " ") + "]");
disp("horigin = " + string(horigin));
disp("hn = [" + strcat((string(hn)), " ") + "]");
disp("yorigin = " + string(yorigin));
disp("yn = [" + strcat((string(yn)), " ") + "]");

