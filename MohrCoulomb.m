function [C,Phi]=MohrCoulomb(Sigma1Ensayo1,Sigma3Ensayo1,PresionPorosEnsayo1...
                      ,Sigma1Ensayo2,Sigma3Ensayo2,PresionPorosEnsayo2)
%==========================================================================
%
% Calcula los parametros C' y Phi' en ese orden
% a partir de datos de 2 ensayos triaxiales             
%                 
%==========================================================================

%====================Esfuerzos Efectivos

s1p=Sigma1Ensayo1-PresionPorosEnsayo1;
s3p=Sigma3Ensayo1-PresionPorosEnsayo1;

s11p=Sigma1Ensayo2-PresionPorosEnsayo2;
s33p=Sigma3Ensayo2-PresionPorosEnsayo2;

%====================Solución del Sistema

F=@(x) [s1p-s3p*tand(45+x(2)/2)^2-2*x(1)*tand(45+x(2)/2);
    s11p-s33p*tand(45+x(2)/2)^2-2*x(1)*tand(45+x(2)/2)]; %Defino Eqs
x0=[0;0]; %Defino punto de inicio

x =fsolve(F,x0);
[C,Phi]=fsolve(F,x0); %Creo el vector solución
% C=x(1); %Extraigo C'
% Phi=x(2); %Extraigo Phi'

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
end
