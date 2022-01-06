
function f = RauberBeuteModell(~,y)
    f = zeros(2,1);
    
    %Parameter
    alpha = 1;
    beta = 1;
    gamma = 1;
    delta = 1;
    
    %Die Modellgleichungen
    f(1) = (alpha - beta*y(2))*y(1);
    f(2) = ( - gamma + delta*y(1))*y(2);
end
