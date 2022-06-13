function [x1,fx]=gen_complex(x0,k,f,g_cons)
N=length(x0);
M=size(g_cons);
M=length(M(:,1));
x1(:,1)=x0;
fx(1)=feval(f,x0);
a=1.3; 
s=rand(N,k)*2-ones(N,k);
s=s/norm(s);
k2=1;
while k2<k
x0=x1(:,1)+a*s(:,k2);
gx=feval(g_cons,x0);
if max(gx)<0
k2=k2+1;
x1(:,k2)=x0;
fx(k2)=feval(f,x0);
else
a=0.7*a;
end
end

