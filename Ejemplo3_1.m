%%Ejemplo 3.1
% Una cimentacion cuadrada tiene 2 X 2 men planta. El suelo que soporta la cimentaci6n tiene
% un angulodefricci6nde phi' = 25° y c' = 20kN/m2 El peso especffico del suelo, -y, es 16.5 kN/m3
% Determine la capacidad de carga permisible sobre la cimentaci6n con un factor de seguridad
% (FS) de 3. Suponga que la profundidad de la cimentaci6n (D1) es de 1.5 my que ocurre una
% falla general por corte en el suelo.

c     = 20;    phi = 25; 
gamma = 16.5;  Df  = 1.5; 
B     = 2;     L   = 2;
Fs    = 3;     A   = B*L;

qu=carga_ultima(c,phi,gamma,B,Df*gamma,'general','cuadrada');
qperm=qu/Fs;
Q=qperm*A;