function visualize(u, Omega)
len = length(Omega(1,:,:));
U = zeros(len,len);
k = 1;
for i=1:len
    for j=1:len
        if isnan(Omega(i,j,1))
        else
            U(i,j) = u(k);
            k = k + 1;
        end
    end
end 
surf(Omega(:,:,1),Omega(:,:,2),U)
end
