function Omega = buildGitter(h)
    knots = 3/h+1;
    Omega = zeros(knots,knots,4);
    counter1 = 1;
    inner = 1;
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
                Omega(i,j,3) = counter1;
                counter1 = counter1 + 1;
            end 
        end 
    end 
    
    for i=1:knots
        for j=1:knots
            counter2 = 0;
            if Omega(i,j,3)==0
            else 
                if j+1<=knots && Omega(i,j+1,3)~=0
                    counter2 = counter2 + 1;
                end 
                if j-1>0 && Omega(i,j-1,3)~=0
                    counter2 = counter2 + 1;
                end 
                if i+1<=knots && Omega(i+1,j,3)~=0
                   counter2 = counter2 + 1;
                end
                if i-1>0 && Omega(i-1,j,3)~=0
                    counter2 = counter2 + 1;
                end
                if i-1>0 && j-1>0 && Omega(i-1,j-1,3)~=0
                    counter2 = counter2 + 1;
                end 
                if i+1<=knots && j+1<=knots && Omega(i+1,j+1,3)~=0
                    counter2 = counter2 + 1;
                end 
                if i-1>0 && j+1<=knots && Omega(i-1,j+1,3)~=0
                    counter2 = counter2 + 1;
                end 
                if i+1<=knots && j-1>0 && Omega(i+1,j-1,3)~=0
                    counter2 = counter2 + 1;
                end 
            end 
            if counter2 == 8
                Omega(i,j,4) = inner;
                inner = inner + 1;
            end 
        end  
    end
end