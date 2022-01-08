function visualize(u, Omega, h)
len = length(Omega(1,:,:));
U = zeros(len,len);
k = 1;
for i=1:len
    for j=1:len
        if Omega(i,j,3)==0
        else
            U(i,j) = u(k);
            k = k + 1;
        end
    end
end 
figure;
surf(Omega(:,:,1),Omega(:,:,2),U)
title("Numerische Approximation mit Gitterweite h= " + h)
end
