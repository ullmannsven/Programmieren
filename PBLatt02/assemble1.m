function [A,b] = assemble1(h,Omega)
H = max(Omega,[],3);
n = max(H,[],'all');
diagonal = 4*ones(n,1);
A = spdiags(diagonal);
b = zeros(n,1);
s = 3/h+1;
counter1 = 1;
k = 0;
for i=1:s
    for j=1:s
        counter2 = 0;
        if Omega(i,j,3)==0
        else 
            if j+1<=s && Omega(i,j+1,3)~=0
                diff = Omega(i,j,3) - Omega(i,j+1,3);
                A(counter1,counter1-diff) = -1;
                counter2 = counter2 + 1;
            end 
            if j-1>0 && Omega(i,j-1,3)~=0
                diff = Omega(i,j,3) - Omega(i,j-1,3);
                A(counter1,counter1-diff) = -1;
                counter2 = counter2 + 1;
            end 
            if i+1<=s && Omega(i+1,j,3)~=0
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
            if i+1<=s && j+1<=s && Omega(i+1,j+1,3)~=0
                counter2 = counter2 + 1;
            end 
            if i-1>0 && j+1<=s && Omega(i-1,j+1,3)~=0
                counter2 = counter2 + 1;
            end 
            if i+1<=s && j-1>0 && Omega(i+1,j-1,3)~=0
                counter2 = counter2 + 1;
            end 
            counter1 = counter1 + 1;
        end 
        if counter2 == 8
            k = k + 1;
            b(counter1-1,1) = f(Omega(i,j,1),Omega(i,j,2));
        end 
    end   
end 

end
