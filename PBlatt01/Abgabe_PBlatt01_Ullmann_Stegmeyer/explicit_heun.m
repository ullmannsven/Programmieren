function Y = explicit_heun(f, y_0, T, tau)

K = round(T/tau); %Anzahl Zeitschritte
d = size(y_0);    %Dimension des Eingabevektors
d = d(2);          
Y = zeros(d,K+1); %Initialisiere leere Matrix, um alle Lösungsvektoren zu speichern
Y(:,1) = y_0;     %Speichern des ersten Lösungsvektors

%Durchführen des Heun Verfahrens 
for i=0:K-1
    g0 = f(tau*i, Y(:,i));
    g1 = f(tau*(i+1), Y(:,i) + tau*f(tau*i, Y(:,i)));
    Y(:,i+1) = Y(:,i) + (tau/2)*(g0 + g1);
end   

end

