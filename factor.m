function [Nc, Nq, Ng,...
          Fcs, Fqs, Fgs,...
          Fcd, Fqd, Fgd,...
          Fci, Fqi, Fgi] = factor(phi,Modelo,B,L,Df,beta)
      
    %----------------------------------------------------------------------
    %
    % Calculo de los factores Nc Nq Ng para un phi dado en grados
    % Para Modelo Terzagui solo importa phi
    %
    %----------------------------------------------------------------------
    
    %Verifico phi!=0 por discontinuidad
    if phi==0
        phi=deg2rad(0.0001);
    end
    phi=deg2rad(phi);
    
    switch Modelo
        case 'Meyerhof'
            Nq    = tan(pi/4 + phi/2)^2*exp(pi*tan(phi));
            Nc    =   (Nq - 1)/tan(phi);
            Ng    = 2*(Nq + 1)*tan(phi);
            
            % Factores de Forma
            Fcs = 1 + (B/L)*(Nq/Nc);
            Fqs = 1 + (B/L)*(tan(phi));
            Fgs = 1 - (B/L)*(0.4);
            
            % Factores de Profundidad
            if Df/B <= 1
                c = Df/B;
            else
                c = atan(Df/B);
            end
            if phi == deg2rad(0.0001)
                 Fcd = 1 + 0.4*c;
                 Fqd = 1;
                 Fgd = 1;
            else
                 Fqd = 1 + 2*tan(phi)*(1-sin(phi)^2)*c;
                 Fcd = Fqd - (1 - Fqd)/(Nq*tan(phi));
                 Fgd = 1;
            end
            
            % Factores de Inclinación
            Fci = (1-beta/90)^2;
            Fqi = Fci;
            Fgi = (1-beta/rad2deg(phi))^2;
            
%             % Factores de Compresibilidad
%             Fcc
%             Fqc
%             Fgc
            
        case 'Terzaghi'
            
            % Nq Nc Ng propuestos por Terzaghi
            Nq    = exp(2*(3*pi/4-phi/2)*tan(phi))/(2*cos(pi/4+phi/2)^2);
            Nc    = (Nq-1)/tan(phi);
          % Ng    = 1/2*((tan(pi/4+phi/2)^2)/cos(phi)^2-1)*tan(phi);
            
            % Valores de Ng de Kumbhojkar
            Ngdic = [0.00;0.01;0.04;0.06;0.10;0.14;0.20;0.27;0.35;0.44;0.56;0.69;
                     0.85;1.04;1.26;1.52;1.82;2.18;2.59;3.07;3.64;4.31;5.09;6.00;
                     7.08;8.34;9.84;11.60;13.70;16.18;19.13;22.65;26.87;31.94;38.04;
                     45.41;54.36;65.27;78.61;95.03;115.31;140.51;171.99;211.56;261.60;
                     325.34;407.11;512.84;650.67;831.99;1072.80];
                 
            % Valores de Ng de Kumbhojkar para angulos no enteros
            if mod(rad2deg(phi),1)==0
                Ng  = Ngdic(rad2deg(phi)+1);
            else
                % Sacada de 'A numerical study of the bearing capacity factor N' 
                Nqp = tan(pi/4+phi/2)^2*exp(pi*tan(phi));
                Ng  = (2*Nqp+1)*(tan(phi))^1.35;
            end
            
            % Factores de Forma
            [Fcs, Fqs, Fgs] = deal(1);
            
            % Factores de profundidad
            [Fcd, Fqd, Fgd] = deal(1);
            
            % Factores de inclinación
            [Fci, Fqi, Fgi] = deal(1);
            
%             % Factores de compresibilidad
%             Fcc = 1; Fqc = 1; Fgc = 1;
    end

     Nq=round(Nq,2);
     Nc=round(Nc,2);
     Ng=round(Ng,2);
end