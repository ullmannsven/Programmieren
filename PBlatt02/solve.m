function u = solve(A,b,u_h, Omega)
    n = max(Omega(:,:,3),[],'all');
    inner = max(Omega(:,:,4),[],'all');
    u = zeros(n,1);
    u_h(:,1) = A\b;
    for i=1:inner
        if u_h(i,2)~=0
            u(u_h(i,2),1) = u_h(i,1);
        end 
    end 
end

