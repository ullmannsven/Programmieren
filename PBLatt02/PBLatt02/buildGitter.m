function Omega = buildGitter(h)
    knots = 3/h+1;
    Omega = zeros(knots,knots,3);
    counter = 1;
    for i=1:knots
        for j=1:knots
            Omega(i,j,1) = (i-1)*h;
            Omega(i,j,2) = (j-1)*h;
            if (i-1)*h > 2 && (j-1)*h < 1
                Omega(i,j,1) = NaN;
                Omega(i,j,2) = NaN;
            elseif (i-1)*h < 1 && (j-1)*h > 2
                Omega(i,j,1) = NaN;
                Omega(i,j,2) = NaN;
            else 
                Omega(i,j,3) = counter;
                counter = counter + 1;
            end 
        end 
    end 
end 
