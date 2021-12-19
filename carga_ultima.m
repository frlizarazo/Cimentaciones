function q_u=carga_ultima(c,phi,gamma,B,L,Df,q,caso_falla_o_modelo,geometria,beta)
    switch caso_falla_o_modelo
        case 'general'
            [Nc,Nq,Ng]=factor(phi);
            switch geometria
                case 'continua'
                    q_u=c*Nc+q*Nq+gamma/2*B*Ng;
                case 'cuadrada'
                    q_u=1.3*c*Nc+q*Nq+0.4*gamma*B*Ng;
                case 'circular'
                    q_u=1.3*c*Nc+q*Nq+0.3*gamma*B*Ng;
            end
        case 'local'
            phi=atan(2/3*tand(phi));
            [Nc,Nq,Ng]=factor(phi);
            switch geometria
                case 'continua'
                    q_u=2/3*c*Nc+q*Nq+gamma/2*B*Ng;
                case 'cuadrada'
                    q_u=0.867*c*Nc+q*Nq+0.4*gamma*B*Ng;
                case 'circular'
                    q_u=0.867*c*Nc+q*Nq+0.3*gamma*B*Ng;
            end
        case 'Meyerhof'
            
            [Nc, Nq, Ng,...
             Fcs, Fqs, Fgs,...
             Fcd, Fqd, Fgd,...
             Fci, Fqi, Fgi]= factor(phi,caso_falla_o_modelo,B,L,Df,beta);
         
            q_u = c*Nc*Fcs*Fcd*Fci + q*Nq*Fqs*Fqd*Fqi + 1/2*gamma*Ng*Fgs*Fgd*Fgi;
        
    end
end