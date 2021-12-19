%% 
function Ejer(x0,f)
syms x
f(x)=f;
fp=diff(f,x);
i=1;
d=[];
l=[];
n=0;
while i==1
    n=n+1;
    xi=x0-f(x0)/fp(x0);
    plot(x0,0,'*');
    hold on;
    err=abs(((xi-x0)/xi)*100);
    l=[l,err];
    d=[d,x0];
    x0=xi;
    if err<1
        i=0;
    end
end

tabla=[double(d); double(l)]
xx=linspace(-0.5,1.5,50);
y=f(xx);
plot(xx,y)
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
end

%% 


