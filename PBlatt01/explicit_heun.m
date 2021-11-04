function Y_Heun = explicit_heun(f, y_0, T, tau)

K = round(T/tau); %Anzahl Zeitschritte
d = size(y_0);    %Dimension des Eingabevektors
d = d(2);          
Y = zeros(d,K+1); %Initialisiere leere Matrix, um alle Lösungsvektoren zu speichern
Y(:,1) = y_0;     %Speichern des ersten Lösungsvektors

%Durchführen des Heun Verfahrens 
for i=1:K
    g0 = f(tau*i, Y(:,i));
    g1 = f(tau*(i+1), Y(:,1) + tau*f(tau*i, Y(:,i)));
    Y(:,i+1) = Y(:,i) + (tau/2)*(g0 + g1);
end 

Y_Heun = Y;     %output

end

