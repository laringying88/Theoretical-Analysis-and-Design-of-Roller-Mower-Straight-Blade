function [c ceq]=fun_cons(x)
c=[ 0.075-x(1)
    x(1)-0.2

    0.075-x(2)
    x(2)-0.1

    0.3-x(3)
    x(3)-0.4
    
    pi/36-x(4)
    x(4)-11*pi/36];
ceq=[];
