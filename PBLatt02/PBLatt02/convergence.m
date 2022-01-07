function error_list = convergence()
 h = [1/4,1/8,1/16,1/32,1/64];
 error_list = zeros(length(h),1);
 for i=1:length(h)
     Omega = buildGitter(h(i));
     [A, b] = assemble1(h(i), Omega);
     u = solve(A,b);
     error_list(i,1) = infty_error(u,Omega);
 end 
 loglog(h,error_list)
 grid on
 title('$ L_{inf}$ Fehler ueber Gitterweite', 'interpreter', 'latex')
 xlabel("Gitterweite h")
 ylabel('$ L_{inf}$ Fehler','interpreter', 'latex')
end
