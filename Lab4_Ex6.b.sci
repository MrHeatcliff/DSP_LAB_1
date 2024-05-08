function [yn, yorigin] = delay (xn, xorigin, k) 
    if k < xorigin then
        yn = xn;
        yorigin = xorigin - k;
    else 

        lenx = size(xn, "c")
        for i = 1 : k-xorigin+1
            yn(1,i) = 0
        end 
        xn_index = 1
        for i = k-xorigin+2 : lenx + k-xorigin+1
            yn(1,i) = xn(1, xn_index)
            xn_index = xn_index + 1
        end 
        yorigin = 1
    end
endfunction

function [yn, yorigin] = advance (xn, xorigin, k) 
    lenx = size(x,"c") 
    if (k + xorigin) <= lenx then
        yn = xn;
        yorigin = xorigin + k;
    else 
        for i = 1: lenx
           yn(1,i) = xn(1,i) 
        end
        for i = lenx+1 : k+xorigin
            yn(1,i) = 0
            
        end
        yorigin =  k+xorigin
    end
endfunction

function [yn, yorigin] = fold(xn, xorigin) 
    len = size(xn, "c")
    for i = 1 : len
        yn(1, i) = xn(1, len-i+1)
    end 
    yorigin = len - xorigin + 1
endfunction

function [yn, yorigin] = multi (x1n, x1origin, x2n, x2origin) 
    len1 = size(x1n, "c")
    len2 = size(x2n, "c")
    curr1ID = 1
    curr2ID = 1
    if (x1origin-1) < (x2origin-1) then
        a = (x2origin-1) - (x1origin-1)
        y1n(1, 1:a) = 0 
        curr1ID = curr1ID+a
        /*
        for i = 1 : a 
           y1n(1, i) = 0 
           curr1ID = curr1ID+1
        end
        */
    elseif (x2origin-1) < (x1origin-1) then
        a = (x1origin-1) - (x2origin-1)
        y2n(1, 1:a) = 0
        curr2ID = curr2ID+a
        /*
        for i = 1 : a 
           y2n(1, i) = 0 
           curr2ID = curr2ID+1
        end
        */
    end
    y1n(1, curr1ID : curr1ID + len1-1) = x1n
    y2n(1, curr2ID : curr2ID + len2-1) = x2n
    yorigin = curr1ID + x1origin -1
    curr1ID = curr1ID + len1 
    curr2ID = curr2ID + len2 
    if (len1-x1origin) < (len2-x2origin) then
        a = len2-x2origin - (len1-x1origin)
        y1n(1, curr1ID : curr1ID+a-1) = 0;
        /*
        for i = 1 : a 
           y1n(1, curr1ID+i-1) = 0 
        end
        */
    elseif (len2-x2origin) < (len1-x1origin) then
        a = len1-x1origin - (len2-x2origin)
        y2n(1, curr2ID : curr2ID+a-1) = 0;
        /*
        for i = 1 : a 
           y2n(1, curr2ID+i-1) = 0 
        end
        */
    end
    for i = 1:size(y1n,"c") 
        yn(1, i) = y1n(1,i)*y2n(1,i)
    end
endfunction

function [y] = add_multi (xn, xorigin) 
    lenx = size(xn, "c")
    y = 0
    for i = 1:lenx
        y = y + xn(1,i)
    end
endfunction

function [yn, yorigin] = convolution (xn, xorigin, hn, horigin) 
    len_left_x = xorigin - 1
    len_right_x = size(xn,"c") - xorigin
    [hn_fold, horigin_fold] = fold (hn, horigin)
    len_left_hf = horigin_fold - 1
    len_right_hf = size(hn_fold,"c") - horigin_fold
    
    //so lan dich trai  = len phai cua h + len trai cua x
    advance_time = len_right_hf + len_left_x
    yn_index = 1
    i = advance_time
    //dich trai -> y(n) n < 0
    while i > 0
        [hf_advance_n, hf_advance_ori] = advance (hn_fold, horigin_fold, i)
        i = i - 1
        [multi_val, multi_ori] = multi (xn, xorigin, hf_advance_n, hf_advance_ori)
        [yn(1, yn_index)] = add_multi (multi_val, multi_ori) 
        yn_index = yn_index + 1
    end 
    
    // gia tri goc toa do cua y(n), n =0
    yorigin = yn_index
    [multi_val, multi_ori] = multi (xn, xorigin, hn_fold, horigin_fold)
    [yn(1, yn_index)] = add_multi (multi_val, multi_ori) 
    yn_index = yn_index + 1
    
    //so lan dich phai  = len trai cua h + len phai cua x
    delay_time = len_left_hf + len_right_x
    i = 1
    //dich phai -> y(n) n > 0
    while i <= delay_time
        [hf_delay_n, hf_delay_ori] = delay (hn_fold, horigin_fold, i)
        i = i + 1
        [multi_val, multi_ori] = multi (xn, xorigin, hf_delay_n, hf_delay_ori)
        [yn(1, yn_index)] = add_multi (multi_val, multi_ori) 
        yn_index = yn_index + 1
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
