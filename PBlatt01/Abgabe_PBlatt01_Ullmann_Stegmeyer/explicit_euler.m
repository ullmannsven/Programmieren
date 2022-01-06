
function Y = explicit_euler(f, y_0, T, tau)
K = round(T/tau);   %Anzahl an Zeitschritten
d = size(y_0);      %Dimension des Startvektors und damit auch die der L�sung 
d = d(2);
Y = zeros(d,K+1);   %Initialisieren Matrix, in welcher alles L�sungsvektoren gespeichert werden
Y(:,1) = y_0;       %Startwert y_0 zur L�sungmatrix hinzuf�gen

%Durchf�hren des Euler Schritts
for i=0:K-1
    Y(:,i+1) = Y(:,i) + tau*f(tau*i,Y(:,i));
end  

end

