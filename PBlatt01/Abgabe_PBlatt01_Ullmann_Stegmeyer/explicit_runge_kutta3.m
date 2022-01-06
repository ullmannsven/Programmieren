function Y = explicit_runge_kutta3(f, y_0, T, tau)

A = [0 0 0; 0.5 0 0; -1 2 0];
b = [0 1/2 1];
c = [1/6 2/3 1/6];

K = round(T/tau); %Anzahl Zeitschritte
d = size(y_0);    %Dimension des Eingabevektors
d = d(2);          
Y = zeros(d,K+1); %Initialisiere leere Matrix, um alle Lösungsvektoren zu speichern
Y(:,1) = y_0;     %Speichern des ersten Lösungsvektors

s = size(b);
s = s(2);
V = zeros(d,s);

for k=1:K
    V(:,1) = Y(:,k);
    for i = 2:s
        for j=1:i-1
            sum1 = A(i,j)*f(tau*k + c(j)*tau,V(:,j));
        end 
    V(:,i+1) = Y(:,k) + tau*sum1;
    end 
    
    for j=1:s
        sum2 = b(j)*f(tau*k + c(j)*tau, V(:,j));
    end 
    
    Y(:,k+1) = Y(:,k) + tau*sum2;
end 

end

