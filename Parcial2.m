%% La zapata de la figura, tiene q0 = 256 kN/m2; B = 3.00 m; L = 18.00 m;
% Df = 1.00 m. Si el estrato de arena tiene: Hs = 4.00m;
% gamma(sand) = 16.00 kN/m3; gammasat(sand) = 17.00 kN/m3. El estrato de arcilla
% tiene: Hc = 3.00 m; gammasat(clay) = 15.00 kN/m3; e0 = 2.50 ; Ccc = 0.25 ; 
% Cs = 0.05 ; Sigmac = 90 kN/m2. zw = 1.15 m. Parámetro A = 0.60 (Skempton); 
% Sabiendo que: gammaw = 9.81 kN/m3. Calcule:

% a) Sigma_0 =  [kN/m2]
% b) OCR = RSC =  
% c) Ict =  
% d) Icm =  
% e) Icb =  
% f) Sigma_t =  [kN/m2]
% g) Sigma_m =  [kN/m2]
% h) Sigma_b =  [kN/m2]
% i) Sigma_prom =  [kN/m2]
% j y k) Sc(p)-1D =  [mm]
% l y m) Kcir = 
% n y o) Sc(p)-3D =  [mm]

qzero     = 267;               % kN/m2 - Esfuerzo de contacto
B         = 2.05;                 % m     - Ancho de la zapata
L         = 3.20;                % m     - Largo de la zapata
Df        = 1.9;                 % m     - Profundidad de desplante
gammaw    = 9.81;              % kN/m3 - Peso especifico del agua

Hs        = 2.9;                 % m     - Espesor estrato arena
gammas    = 15.5;                % kN/m3 - Peso especifico de la arena
gammassat = 18.6;                % kN/m3 - Peso especifico de la arena saturada

Hc        = 3.2;                 % m     - Espesor estrato arcilla
gammacsat = 17.8;                % kN/m3 - Peso especifico de la arcilla saturada

e0        = 1.10;              %       - Relación de vacíos
Ccc       = 0.33;              %       - Coeficiente de compresion de campo
Cs        = 0.06;              %       - Cueficiente de recompresion

% Sigma_c   = ;                % kN/m2 - Esfuerzo de preconsolidación
naf       = 1.9;              % m     - Altura nivel freatico
A         = 0.76;               %       - Skepton

% a) Calculo de Sigma_0

Sigma_0   = naf*gammas + (Hs-naf)*(gammassat-gammaw) + Hc/2*(gammacsat-gammaw);

% b) Calculo OCR

OCR       = 1.25;
Sigma_c   = Sigma_0/OCR;
if OCR   == 1
    Consolidacion = 'NC';
else
    Consolidacion = 'SC';
end

%Calculamos profundidad de la arcilla desde nivel de desplante: top,
%medium, button 
zt = Hs - Df; 
zm = zt + Hc/2; 
zb = zt + Hc; 

%Calculamos parámetros de la ecuciones 5.12 y 5.13 para las distintas
%profundidades
m1  = 1.561;
n1t = 0.976; 
n1m = 2.536; 
n1b = 4.097; 

% c d e) calculo Ict Icm Icb
I     = [Ic_func(m1,n1t) Ic_func(m1,n1m) Ic_func(m1,n1b)];

% f g h i) calculo SigmaT SigmaM SigmaB SigmaProm
Sigma = qzero*I;
Sigma_prom=(Sigma(1) + 4*Sigma(2) + Sigma(3))/6;

% Calculo Sp
Sp = Sp_func(Sigma_0, Sigma_c, Sigma_prom, Hc, e0, Consolidacion, Ccc, Cs);

% Calculamos el asentamiento por consolidación primaria 3D
Bq = B +zt ; 
Lq = L +zt ; 

% Calculamos el diámetro equivalente 
Be = sqrt(4*Bq*Lq/pi);  

% Calculamos parámetro K para una cimentación circular 
Kcir = A + (1-A)*(0.3700272163*(Hc/Be)^(-0.4227944812)); 

% Asentamiento tridimensional 3D
Sp3D = Kcir*Sp; %mm 

%%

%% Considere una fundación sobre arena, con B = 2.80 m; L = 19.60 m; 
% Df = 1.00 m; gamma = 20.30 kN/m3; q_ = 286 kN/m2; t = 63 años. Bajo la 
% línea de desplante existen 3 suelos con los siguientes espesores 
% y módulos de elasticidad: dz1 = 1.050 m; Es1 = 10300 kN/m2;
% dz2 = 4.200 m; Es2 = 15702 kN/m2; dz3 = 4.750 m; Es3 = 13504 kN/m2. 
% Usando el método del Factor de Influencia de la Deformación Unitaria
% estime:

B     = 1.8;       % m     - Ancho fundación
L     = 0.85*B;      % m     - Largo fundación
Df    = 0.9;       % m     - Profundidad de desplante
gamma = 15.8;      % kN/m3 - Peso especifico del suelo
q_    = 215;        % kN/m2 - Carga bruta
t     = 15;         % años  - Tiempo de asentamiento

dz1 = 0.735;        % m     - Espesor estrato 1
Es1 = 5600;        % kN/m2 - Modulo elasticidad 1

dz2 = 2.940;        % m     - Espesor estrato 2
Es2 = 9050;        % kN/m2 - Modulo elasticidad 2

dz3 = 6.13;        % m     - Espesor estrato 3
Es3 = 7450;        % kN/m2 - Modulo elasticidad 3

% Por legibilidad defino relación L/B
LB  = L/B;

% Usando formula de Salgado para z1 y z2:
z0  = 0;
z1  = (0.5 + 0.0555*(LB-1))*B;
z2  = (  2 +  0.222*(LB-1))*B;

% Calculo Iz(0)
q   = gamma*Df;
qz1 = gamma*(Df + z1);

Iz0 = (0.1 + 0.0111*(LB-1));
Iz1 = 0.5+0.1*(sqrt((q_-q)/qz1));
Iz2 = 0;

% Defino nuevos estratos
dzn1 = dz1;
dzn2 = z1 - dz1;
dzn3 = dz1 + dz2 -z1;
dzn4 = z2 - z1 - dzn3;

zm1 = dzn1/2;
zm2 = dzn1 + dzn2/2;
zm3 = dzn1 + dzn2 + dzn3/2;
zm4 = dzn1 + dzn2 + dzn3 + dzn4/2;

% Calculando los Iz en esos puntos medios interpolando:
Izm1 = Iz0 + ((Iz1-Iz0)/(z1-z0))*(zm1-z0);   
Izm2 = Iz0 + ((Iz1-Iz0)/(z1-z0))*(zm2-z0);  
Izm3 = Iz1 + ((Iz2-Iz1)/(z2-z1))*(zm3-z1);  
Izm4 = Iz1 + ((Iz2-Iz1)/(z2-z1))*(zm4-z1);   

% Sacando el IZ/Es*Dz para cada estrato:
f1 = (Izm1*dzn1)/Es1;
f2 = (Izm2*dzn2)/Es2;  
f3 = (Izm3*dzn3)/Es2; 
f4 = (Izm4*dzn4)/Es3;

%Sumandolos:
SF = f1 + f2 +f3 ; 

%Ahora, sacando los coeficientes C1 Y C2:
C1 = 1 - 0.5*(q/(q_-q));
C2 = 1 + 0.2*log10(t/0.1);

%Obteniendo el asentamiento elastico en mm:
Se = (C1*C2*(q_-q)*SF)*1000;  %mm

%Resultados
x   = [z1; z2; Iz0; Iz1; C1; C2; Se];
  