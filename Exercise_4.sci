//start a file with
clear
//input
x1n = [0 1 3 -2]
x1origin = 1
x2n = [0 1 2 3]
x2origin = 2
// some functions for tasks

function [yn, yorigin] = advance(xn, xorigin, k)
//condition for input
    if k > 0 then
        yorigin = xorigin + k
        if yorigin > size(xn,"c") then
            // add more zero vectors if overflow
            yn = cat(2, xn, zeros(1:(yorigin - size(xn,"c"))))
        else
            // no overflow, y is same as x
            yn = xn
        end
        
    else
        yn = 0
        yorigin = -1
        halt('ERROR: Enter k > 0 or using the delay function')
    end
endfunction

function [yn, yorigin] = add (x1n, x1origin, x2n, x2origin)
    i_min = min(1 - x1origin, 1 - x2origin)
    i_max = max(size(x1n,"c") - x1origin, size(x2n,"c") - x2origin)
    n = max(1, i_min)
    for i = i_min:i_max
        if i + x1origin < 1 | i + x1origin > size(x1n,"c") then
            x1 = 0
        else
            x1 = x1n(i + x1origin)
        end
        
        if i + x2origin < 1 || i + x2origin > size(x2n,"c") then
            x2 = 0
        else
            x2 = x2n(i + x2origin)
        end
        
        yn(1,n) = x1 + x2
        if i == 0 then
            yorigin = n
        end
        n = n + 1
    end
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
//calculate
[yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
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
str = "y = x1(n) + x2(n)"
t.text = str
t = a.x_label
t.font_foreground = color("blue")
t.font_size = 5
t.text = "n"
