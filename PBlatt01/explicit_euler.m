%Explizites Euler Verfahren

function Y_Euler = explicit_euler(f, y_0, T, tau)
K = round(T/tau);   %Anzahl an Zeitschritten
d = size(y_0);      %Dimension des Startvektors und damit auch die der Lösung 
d = d(2);
Y = zeros(d,K+1);   %Initialisieren Matrix, in welcher alles Lösungsvektoren gespeichert werden
Y(:,1) = y_0;       %Startwert y_0 zur Lösungmatrix hinzufügen

%Durchführen des Euler Schritts
for i=1:K
    Y(:,i+1) = Y(:,i) + tau*f(tau*i,Y(:,i));
end 

Y_Euler = Y;        %output

end

