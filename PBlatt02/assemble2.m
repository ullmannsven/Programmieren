function [A,b,u] = assemble2(h,Omega)
knots = 3/h+1;
inner = max(Omega(:,:,4),[],'all');
A = sparse(inner,inner);
b = zeros(inner,1);
u = zeros(inner,2);
counter0 = 1;
counter1 = 1;
for i=1:knots
    for j=1:knots
        if Omega(i,j,4)==0
        else 
            A(counter1,counter1) = 4;
            if j+1<=knots && Omega(i,j+1,4)~=0
                diff = Omega(i,j,4) - Omega(i,j+1,4);
                A(counter1,counter1-diff) = -1;
            end 
            if j-1>0 && Omega(i,j-1,4)~=0
                diff = Omega(i,j,4) - Omega(i,j-1,4);
                A(counter1,counter1-diff) = -1;
            end 
            if i+1<=knots && Omega(i+1,j,4)~=0
                diff = Omega(i,j,4) - Omega(i+1,j,4);
                A(counter1,counter1-diff) = -1;
            end
            if i-1>0 && Omega(i-1,j,4)~=0
                diff = Omega(i,j,4) - Omega(i-1,j,4);
                A(counter1,counter1-diff) = -1;
            end
        u(counter1,2) = counter0;
        b(counter1,1) = f(Omega(i,j,1),Omega(i,j,2));
        counter1 = counter1 + 1;
        end 
        if Omega(i,j,3) ~= 0
            counter0 = counter0 + 1;
        end 
    end   
end 
A = (1/(h^2))*A;
end
