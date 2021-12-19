%============================================================
%
%        C' y Phi' Envolvente de Falla de Mohr Coulomb
%                Franklin Andrés Lizarazo
%
%============================================================

%====================Ingreso de Datos

%Ensayo 1
s1=329.2; %Esfuerzo principal 1
s3=82.8; %Esfuerzo principal 3
u=0; %Presión de poros

%Ensayo 2
s11=558.6; %Esfuerzo principal 1
s33=165.6; %Esfuerzo principal 3
uu=0; %Presión de poros

%====================Esfuerzos Efectivos

s1p=s1-u;
s3p=s3-u;

s11p=s11-uu;
s33p=s33-uu;

%====================Solución del Sistema

F=@(x) [s1p-s3p*tand(45+x(2)/2)^2-2*x(1)*tand(45+x(2)/2);
    s11p-s33p*tand(45+x(2)/2)^2-2*x(1)*tand(45+x(2)/2)]; %Defino Eqs
x0=[0;0]; %Defino punto de inicio

x=fsolve(F,x0); %Creo el vector solución
c=x(1) %Extraigo C'
phi=x(2) %Extraigo Phi'

%====================Gráfica del Circulo

r=(s1p-s3p)/2;
c=(s1p+s3p)/2;

rr=(s11p-s33p)/2;
cc=(s11p+s33p)/2;

xp=0:10:600; %Defino intervalo X
yp=sqrt(r^2-(xp-c).^2); %Circulo 1
yyp=sqrt(rr^2-(xp-cc).^2); %Circulo 2
yyy=x(1)+xp*tand(x(2)); %Envolvente

plot(xp,yp,xp,yyp,xp,yyy);




%% 

y=MohrCoulomb(329.2,82.8,0,558.6,165.6,0)

