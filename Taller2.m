%% TRABAJO EXTRACLASE 1: ANÁLISIS DE CAPACIDAD DE SOPORTE DE CIMENTACIONES SUPERFICIALES
% =========================================================================
%
%   Asignatura: CIMENTACIONES
%   Docente: OSCAR CORREA CALLE
%   Período: 2021-2S
%   Fecha: 17/11/21
%
%   Verifique la capacidad de carga última y el factor de seguridad de una 
%   zapata aislada sometida a una carga vertical dada por la combinación de 
%   carga muerta + carga viva máxima de: P = DL + LL = 380 kN. Considere que
%   el factor de seguridad mínimo es de FS = 3.0. El nivel freático está a 
%   1.50 m. El perfil de suelo está compuesto por 1 estrato de suelo, con las
%   siguientes características:
%
%==========================================================================

%% Información del suelo
material = 'Arcilla';
P        = 380;                   %kN-Combinacion de carga P=DL+LL
%Fs       = 3;                    %Factor de seguridad minimo
le       = [0 8];                 %m-Limites del estrato
h        = 8;                     %m-Espesor del estrato
g        = 18;                    %kN/m3-Peso humedo
gSat     = 19;                    %kN/m3-Peso saturado
cu       = 50;                    %kN/m2-Resistencia no derenada
phi      = 0;                     %°-Angulo de friccion
naf      = 1.5;                   %m-Profundidad nivel freatico

%% Información de la zapata

B  = 2;         %m-Ancho zapata
L  = 2;         %m-Largo zapata
t  = 0.4;       %m-Espesor zapata
dc = 0.4*0.4;   %m-Dimensiones de la columna
df = 1;         %m-Profundidad de desplante

%% Información del material de la zapata y el relleno

gc = 23.54;     %kN/m3-Peso concreto
gr = 20.00;     %kN/m3-Peso relleno sobre zapata

%% SOLUCIÓN

%1. Calcular el esfuerzo de contacto para diseño (transmitido por la
%estructura de cimentación al suelo): Asumiendo una distribución uniforme,
%el esfuerzo de contacto q0, se calcula como:

A     = B*L;                   %Area de la base de la zapata

wz    = A*t*gc;                %Peso propio de la zapata
wc    = dc*(df-t)*gc;          %Peso propio de la columna
wr    = (A-dc)*(df-t)*gr;      %Peso propio del relleno

u     = 0;                     %Presion de poros, por ahora 0

qzero = (P + wz + wc + wr)/A-u;      %Esfuerzo de contacto

%2. Calcular la capacidad de carga última qu, usando la ecuación general
%de capacidad de carga de Meyerhof (1963), asumiendo falla por corte general
%y condición de carga no drenada por tratarse de arcilla saturada.

qu    = carga_ultima(cu,phi,g,B,L,df,qzero,'Meyerhof','Cuadrada',0);

%3. Calcular el factor de seguridad FS = qu/q0, el cual debería ser mayor
%o igual a 3.0.

Fs    = qu/qzero;

