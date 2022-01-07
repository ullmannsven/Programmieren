function [A,b] = assemble1(h,Omega)
n = max(Omega(:,:,3),[],'all');
A = sparse(n,n);
b = zeros(n,1);
knots = 3/h+1;
counter1 = 1;
for i=1:knots
    for j=1:knots
        counter2 = 0;
        if Omega(i,j,3)==0
        else 
            A(counter1,counter1) = 4;
            if j+1<=knots && Omega(i,j+1,3)~=0
                diff = Omega(i,j,3) - Omega(i,j+1,3);
                A(counter1,counter1-diff) = -1;
                counter2 = counter2 + 1;
            end 
            if j-1>0 && Omega(i,j-1,3)~=0
                diff = Omega(i,j,3) - Omega(i,j-1,3);
                A(counter1,counter1-diff) = -1;
                counter2 = counter2 + 1;
            end 
            if i+1<=knots && Omega(i+1,j,3)~=0
                diff = Omega(i,j,3) - Omega(i+1,j,3);
                A(counter1,counter1-diff) = -1;
                counter2 = counter2 + 1;
            end
            if i-1>0 && Omega(i-1,j,3)~=0
                diff = Omega(i,j,3) - Omega(i-1,j,3);
                A(counter1,counter1-diff) = -1;
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
            counter1 = counter1 + 1;
        end 
        if counter2 == 8
            b(counter1-1,1) = f(Omega(i,j,1),Omega(i,j,2));
        end 
    end   
end 
A = (1/h^2)*A;
end
