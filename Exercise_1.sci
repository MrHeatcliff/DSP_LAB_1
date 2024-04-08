//start with a clear
clear
//fucntion delay
function [yn, yorigin] = delay(xn, xorigin, k)
    if k <= xorigin then
        yorigin = xorigin - k;
        yn = xn;
    else 
        yorigin = 0;
        for i = 1: (k-xorigin)
            yn(1,i) = 0;
        end
        for i = 1:size(xn,"c")
            yn(1,k-xorigin+i) = xn(1,i);
        end
    end
endfunction

//input
xn = [1 -2 3 6];
xorigin = 2;
k = 4;
// output
[yn, yorigin] = delay(xn, xorigin, k);

//conditions for input
if xorigin < 1 | xorigin > size(xn,"c") then
    halt('ERROR: Invalid input')
end

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
//draw plot
clf
draw_plot(xn, xorigin, "red")
draw_plot(yn, yorigin, "blue")
// add some properties
legend(['xn', 'yn'], pos = -2)
a = gca()
a.grid = [-1, 33]
a.children(1).font_size = 3
t = a.title
t.font_foreground = color("red")
t.font_size = 5
str = "y = x(n - k), k = " + string(k)
t.text = str
t = a.x_label
t.font_foreground = color("blue")
t.font_size = 5
t.text = "n"
