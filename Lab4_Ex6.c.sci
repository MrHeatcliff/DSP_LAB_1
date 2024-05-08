

function [yn, yorigin] = convolution (xn, xorigin, hn, horigin) 
    // tim so mau va goc toa do cua yn
    lenx = size(xn,"c")
    lenh = size(hn,"c")
    leny = lenx + lenh - 1
    // tao yn rong
    for i = 1:leny
        yn(1,i) = 0
    end
    yorigin = (xorigin-1) + (horigin-1) + 1
    //Tim ma tran H 
    for i = 1:lenx
        for j = 1:lenh
            H(i,j) = xn(1,i)*hn(1,j)
        end
    end
    
    // Tinh tich chap
    for i = 1:lenx
        for j = 1:lenh
            yn(1,i+j - 1) = yn(1,i+j - 1) + H(i,j)
        end
    end
    
    
endfunction

//run func
xn = [1, 2, -3, 2, 1]
xorigin = 1
hn = [1, 0, -1]
horigin = 1
[yn, yorigin] = convolution (hn, horigin, xn, xorigin) 
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
str = "y(n) = x(n)*h(n)"
t.text = str
t = a.x_label
t.font_foreground = color("blue")
t.font_size = 5
t.text = "n"

