//start with a clear
clear
//fucntion multi
function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    sizex1 = size(x1n, "c");
    sizex2 = size(x2n, "c");
    if x1origin > x2origin then
        add_var = x1origin - x2origin;
        x2n(add_var+1:sizex2+add_var) = x2n(1:sizex2);
        x2n(1:add_var) = 0;
        x1n(sizex1+1:sizex1+add_var) = 0;
        yn = x1n .* x2n;
        yorigin = x1origin;
    elseif x1origin < x2origin then
        add_var = x2origin - x1origin;
        x1n(add_var+1:sizex2+add_var) = x1n(1:sizex2);
        x1n(1:add_var) = 0;
        x2n(sizex1+1:sizex1+add_var) = 0;
        yn = x1n .* x2n;
        yorigin = x2origin;
    else
        yn =x1n .* x2n;
        yorigin = x1origin;
    end
endfunction

//input
x1n = [1 -2 3 6];
x2n = [-1 2 4 5];
x1origin = 1;
x2origin = 2;
k = 1;
// output
[yn, yorigin] = multi(x1n, x1origin, x2n, x2origin);

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
//calculate
//display
disp("x1origin = " + string(x1origin));
disp("x1n = [" + strcat((string(x1n)), " ") + "]");
disp("x2origin = " + string(x2origin));
disp("x2n = [" + strcat((string(x2n)), " ") + "]");
disp("yorigin = " + string(yorigin));
disp("yn = [" + strcat((string(yn)), " ") + "]");
//draw plot
clf
draw_plot(x1n, x1origin, "red")
draw_plot(x2n, x2origin, "magenta")
draw_plot(yn, yorigin, "blue")
// add some properties
legend(['x1n', 'x2n', 'yn'], pos = -2)
a = gca()
a.grid = [-1, 33]
a.children(1).font_size = 3
t = a.title
t.font_foreground = color("red")
t.font_size = 5
str = "y = x1(n) . x2(n)"
t.text = str
t = a.x_label
t.font_foreground = color("blue")
t.font_size = 5
t.text = "n"
