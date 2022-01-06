function error = infty_error(Omega, u)
analytic_sol_func = @(x,y) sin(pi*x).*sin(2*pi*y);
analytic_sol = zeros(n,1);
len = length(Omega(1,:,:));
k = 1;

for i=1:len
    for j=1:len
        analytic_sol(k) = analytic_sol_func(Omega(i,j,1),Omega(i,j,2));
        k = k+1;
    end 
end
error = max(u - analytic_sol);

end

