function Sp = Sp_func(Sigma_0,Sigma_c,Sigma_Prom,Hc,e0, ...
                      Estado_consolidacion,Ccc,Cs)
    H = Hc/(1 + e0);
    switch Estado_consolidacion
        case 'NC'
            Sp = H*Ccc*log10((Sigma_0 + Sigma_Prom)/Sigma_0);
        case 'SC'
            if Sigma_0 + Sigma_Prom <= Sigma_c
                Sp = H*Cs*log10((Sigma_0 + Sigma_Prom)/Sigma_0);
            else
                Sp = H*Cs*log10(Sigma_c/Sigma_0) + ...
                     H*Ccc*log10((Sigma_0 + Sigma_Prom)/Sigma_c);
            end
    end
    
    Sp = Sp*1000;
end