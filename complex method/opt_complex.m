function [xo,fo,go]=opt_complex(f,g_cons,x0,xl,xu,TolX,TolFun,MaxIter)
N=length(x0);
M=size(g_cons);
M=length(M(:,1));
k1=0;
k=N+1;%单纯形顶点个数
gx=ones(M,1);
while max(gx)>0   
x0=xl+rand(N,1).*xu;
gx=feval(g_cons,x0);
end
[x1,fx]=gen_complex(x0,k,f,g_cons);
flag1=1;flag2=1;flag3=1;
k1=0
fx
x1
fprintf('此处暂停，请按下任意键继续\n')
pause
while k1<MaxIter
flag1=1;flag2=1;flag3=1;
k1=k1+1
[fx,I]=sort(fx);
for i=1:k
x2(:,i)=x1(:,I(i));
end
x1=x2;
fmax1=fx(k);
imax1=I(k);
fmin=fx(1);
imin=I(1);
fmax2=fx(k-1);
imax2=I(k-1);
%计算形心
xc=zeros(N,1);
for i=1:k
xc=xc+x1(:,i);
end
xc=xc-x1(:,imax1);
xc=xc/(k-1);     
gxc=feval(g_cons,xc);
alpha=1.31;  
%反射
xr=xc+alpha*(xc-x1(:,imax1));
gxr=feval(g_cons,xr)
if max(gxr)<0
fxr=feval(f,xr);
if fxr<fmax1
fprintf('反射成功\n')
fmax1,fxr
fmax1=fxr;
fx(imax1)=fxr;
x1(:,imax1)=xr; 
flag1=-1;
else
%反射失败
flgg1=1;             
end
else
%反射失败
flag1=1;      
end 
gama=0.7;
if flag1==-1        
fprintf('延伸\n')
xe=xr+gama*(xr-xc);
gxe=feval(g_cons,xe)
if max(gxe)<0
fxe=feval(f,xe);
if fxe<fmax1
fprintf('延伸成功\n')
fxe,fmax1
fx(imax1)=fxe;
fmax1=fxe;                
x1(:,imax1)=xe;
flag2=-1;  
else
%延伸失败
flag2=1;                           
end
else
%延伸失败
flag2=1;         
end
end
beta=0.7;
if  flag1~=-1&flag2~=-1
fprintf('收缩\n')
xk=x1(:,imax1)+beta*(xc-x1(:,imax1));
gxk=feval(g_cons,xk)
if max(gxk)<0
fxk=feval(f,xk);
if fxk<fmax1
fprintf('收缩成功\n')
fxk,fmax1
fmax1=fxk;
fx(imax1)=fxk;
x1(:,imax1)=xk;
flag3=-1;
else
%收缩失败
flag3=1;
end
else
%收缩失败
flag3=1;    
end
end        
if  flag1~=-1&flag2~=-1&flag3~=-1
fprintf('flag1,flag2,flag3\n %d %d %d\n',flag1,flag2,flag3)
fprintf('重新生成单纯形\n')
[fx,I]=sort(fx);
imin=I(1);
x0=x1(:,imin);                   
[x1,fx]=gen_complex(x0,k,f,g_cons)                  
end
end
xo=x1(:,imin);
fo=feval(f,xo);
go=feval(g_cons,xo);
k1

