//start with a clear
clear
//fucntion fold
function [yn, yorigin] = fold(xn, xorigin)
    sizex = size(xn, "c");
    yn = flipdim(xn, 2)
    yorigin = sizex - xorigin + 1;
endfunction

//input
xn = [1 -2  -1 3 2];
xorigin = 3;
k = 1;
// output
[yn, yorigin] = fold(xn, xorigin);

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
str = "y = x(-n)"
t.text = str
t = a.x_label
t.font_foreground = color("blue")
t.font_size = 5
t.text = "n"

