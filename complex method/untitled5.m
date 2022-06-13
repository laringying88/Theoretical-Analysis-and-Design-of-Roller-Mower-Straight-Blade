clc;
clear all;

f=inline('542.7425*(4*asin(x(3)/x(1)*tan(55*pi)/180)*x(1)*cos(x(4)+20*pi/180)/x(3)*tan(x(4))+sin(x(4)+20*pi/180)*(atan(x(2)/x(1))*(3*x(2) / 2*x(3)*tan(x(4))-2)+2*(2-x(2)/x(3)*tan(x(4)))*asin(x(3)/x(1)*tan(55*pi)/180)))','x');
TolX=1e-6;
TolFun=1e-6;
%x0=[0.1,0.08,0.35,45*pi/180]';
%xl=[8,14,21,29]';
x0=[8,14,21,29]';
xl=[0.1,0.08,0.35,45*pi/180]';
xu=[7 9 11 12]';
MaxIter=65; 
options=optimset('LargeScale','off');
[xo,fxo,g]=opt_complex(f,@fun_cons,x0,xl,xu,TolX,TolFun,MaxIter)
[xo,fo]=fmincon(f,x0,[],[],[],[],xl,xu,@fun_cons,options)





