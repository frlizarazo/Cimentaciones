function I=Ic_func(m,n)
    I = (2/pi)*((m*n/(sqrt(1+m^2+n^2)))*((1+m^2+2*n^2)/((1+n^2)*...
        (m^2+n^2))) + asin(m/(sqrt(m^2+n^2)*(sqrt(1+n^2)))));
end