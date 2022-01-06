function convergence(u, Omega)
 h = [1,1/2,1/4,1/8,1/16,1/32];
 errors = zeros(length(h));
 for i=1:lenght(h)
     Omega = buildGitter(h);
     [A, b] = assemble1(h, Omega);
     u = solve(A,b);
     errors(i) = infty_error(Omega,u);
 end 
 errors
 plot(h,errors)
end
