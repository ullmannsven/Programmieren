function T = convergence()
 H= [1/4,1/8,1/16,1/32,1/64,1/128];
 error= zeros(length(H),1);
 for i=1:length(H)
     Omega = buildGitter(H(i));
     [A, b, u_h] = assemble2(H(i), Omega);
     u = solve(A,b,u_h,Omega);
     error(i,1) = infty_error(u,Omega);
 end 
 T = table(H',error(:,1),'VariableNames',{'Gitterweite','Fehler'});
 figure;
 loglog(H,error(:,1))
 grid on
 title('$ L_{inf}$ Fehler ueber Gitterweite', 'interpreter', 'latex')
 xlabel("Gitterweite h")
 ylabel('$ L_{inf}$ Fehler','interpreter', 'latex')
end
