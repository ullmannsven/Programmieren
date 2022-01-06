%Aufgabe 3 logistische DGL

%Zeitschritte
tau = 1/80 * [1, 1/2, 1/8, 1/16, 1/32, 1/64, 1/128, 1/258, 1/512];

%Parameter und Startwerte
t_0 = 0;
T = 1; 
alpha = 10; 
beta = 1;
Xi = alpha / beta; 
p_0 = 5; %wert fehlt ??

%leere Arrays um  Fehler und Zeit zu speichern
cpuTime = zeros(1,length(tau));
maxErrors = zeros(1,length(tau));

%Die exakte Lösung
AnalyticSol = @(t) Xi*p_0/(p_0 + (Xi - p_0)*exp(-alpha*(t - t_0)));

choose = input('Enter: 1 (Euler), 2 (Heun), 3 (RK3): ');

switch choose 
    
    case 1
    for i=1:length(tau)
        K = round(T/tau(i)); %Anzahl Zeitschritte 

        AnalyticSolVal = zeros(1,K+1); %leerer Array um korrekte analytische Werte zu speichern
        for j=1:K+1
            AnalyticSolVal(j) = AnalyticSol(tau(i)*(j-1));
        end 

        %Zeitmessung Euler-Verfahren
        tic;
        sol = explicit_euler(@funcLogisticDGL, p_0, T, tau(i)); 
        cpuTime(i) = toc;

        errors = zeros(1,K+1); %leerer Array um Fehler zu speichern
        for j=1:K+1
            errors(j) = abs(AnalyticSolVal(j) - sol(j)); 
        end 
        
        %größten Fehler finden
        maxErrors(i) = max(errors); 
    end 
    
    %plot maxError über Zeitschritt 
    figure
    loglog(tau,maxErrors, '-o')
    xlabel('timestep')
    ylabel('error')
    title('Euler-Verfahren: error to analytic solution over timestep')
    
    %plot MaxError über CPU Time
    figure
    semilogy(cpuTime, maxErrors, '-o')
    xlabel('cpuTime')
    ylabel('error')
    title('Euler-Verfahren: error over cpu runtime')
    
    
    case 2
    for i=1:length(tau)
        K = round(T/tau(i));

        AnalyticSolVal = zeros(1,K+1);
        for j=1:K+1
            AnalyticSolVal(j) = AnalyticSol(tau(i)*(j-1));
        end 

        tic;
        sol = explicit_heun(@funcLogisticDGL, p_0, T, tau(i)); 
        cpuTime(i) = toc;

        errors = zeros(1,K+1);
        for j=1:K+1
            errors(j) = abs(AnalyticSolVal(j) - sol(j)); 
        end 

        maxErrors(i) = max(errors); 
    end 
    
    figure
    loglog(tau,maxErrors, '-o')
    xlabel('timestep')
    ylabel('error')
    title('Heun-Verfahren: error to analytic solution over timestep')

    figure
    semilogy(cpuTime, maxErrors, '-o')
    xlabel('cpuTime')
    ylabel('error')
    title('Heun-Verfahren: error over cpu runtime')
    
    
    case 3
        
    A = [0 0 0; 0.5 0 0; -1 2 0];
    b = [0 1/2 1];
    c = [1/6 2/3 1/6];
        
    for i=1:length(tau)
        K = round(T/tau(i));

        AnalyticSolVal = zeros(1,K+1);
        for j=1:K+1
            AnalyticSolVal(j) = AnalyticSol(tau(i)*(j-1));
        end 

        tic;
        sol = explicit_runge_kutta3(@funcLogisticDGL, p_0, T, tau(i), A, b, c); 
        cpuTime(i) = toc;

        errors = zeros(1,K+1);
        for j=1:K+1
            errors(j) = abs(AnalyticSolVal(j) - sol(j)); 
        end 

        maxErrors(i) = max(errors); 
    end 
    
    figure
    loglog(tau,maxErrors, '-o')
    xlabel('timestep')
    ylabel('error')
    title('RK3-Verfahren: error to analytic solution over timestep')

    figure
    semilogy(cpuTime, maxErrors, '-o')
    xlabel('cpuTime')
    ylabel('error')
    title('RK3-Verfahren: error over cpu runtime')
     
    otherwise  
        error('Wrong input')
   
end 
