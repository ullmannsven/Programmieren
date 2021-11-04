%script to numerically approximate the so called "R�uber-Beute Modell",
%which is based on the Lotka Voltera equations


T = 25;                                 %Endzeit
tau = [0.64, 0.32, 0.16, 0.08 0.04];    %Zeitschritte
y0 = [0.5, 0.5];                        %Startvektor

%Steps etc.
meshstep = 0.5;                         %Gitterbreite f�r Vektorfeld
axisRange = 5;                          %x und y Achsenl�nge f�r Gitter
steps = axisRange/meshstep + 1;    

A = zeros(2,steps*steps);                %Vektor um alle L�sungen an Gitterpunkten f�rs Vektorfeld zu speichern
[x,y] = meshgrid(0:meshstep:axisRange, 0:meshstep:axisRange);   %Gitter f�r Vektorfeld

choose = input('Enter: 1 (Euler), 2(Heun), 3 (RK3): ');

switch choose
    case 1
    for k=1:length(tau)
        K = round(T/tau(k));    %Anzahl Zeitschritte

        %DGL L�sung mit Euler
        sol = explicit_euler(@RauberBeuteModell, y0, T, tau(k));
        counter = 1;

        %Matrix A bef�llen, um L�sungen f�r Vektorfeld an den Gitterpunkten zu
        %erhalten
        for i=0:steps-1
           for j = 0:steps-1
                A(:,counter) = RauberBeuteModell(0,[meshstep*j,meshstep*i]);
                counter = counter + 1; 
           end 
        end 

        %Vektor A in 2 Matrizen speichern
        dx = reshape(A(1,:),[steps,steps]).';
        dy = reshape(A(2,:),[steps,steps]).';

        %plot des Vektorfeld und der L�sungskurve
        % x-Achse: Beute, y-Achse:R�uber
        figure
        hold on
        quiver(x,y,dx,dy)
        plot(sol(1,:), sol(2,:))
        xlabel('R�uber')
        ylabel('Beute')
        title("explicit Euler with Timestep: " + tau(k)+ " seconds");
        hold off

        %plot des Beute und R�uber Verlaufs jeweils �ber die Zeit
        figure 
        time = linspace(0,T,K+1);
        plot(time,sol(1,:))
        hold on
        plot(time, sol(2,:))
        legend('Beute','Rauber')
        xlabel('Zeit')
        ylabel('Bestand')
        title("R�uber-Beute Zeitverlauf mit expl. Euler-Verfahren, Zeitschritt: " + tau(k) + " seconds")
        hold off
    end 
    
    case 2
    for k=1:length(tau)
        K = round(T/tau(k));    %Anzahl Zeitschritte

        %DGL L�sung mit Euler
        sol = explicit_heun(@RauberBeuteModell, y0, T, tau(k));
        counter = 1;

        %Matrix A bef�llen, um L�sungen f�r Vektorfeld an den Gitterpunkten zu
        %erhalten
        for i=0:steps-1
           for j = 0:steps-1
                A(:,counter) = RauberBeuteModell(0,[meshstep*j,meshstep*i]);
                counter = counter + 1; 
           end 
        end 

        %Vektor A in 2 Matrizen speichern
        dx = reshape(A(1,:),[steps,steps]).';
        dy = reshape(A(2,:),[steps,steps]).';

        %plot des Vektorfeld und der L�sungskurve
        % x-Achse: Beute, y-Achse:R�uber
        figure
        hold on
        quiver(x,y,dx,dy)
        plot(sol(1,:), sol(2,:))
        xlabel('R�uber')
        ylabel('Beute')
        title("explicit Heun with Timestep: " + tau(k)+ " seconds");
        hold off

        %plot des Beute und R�uber Verlaufs jeweils �ber die Zeit
        figure 
        time = linspace(0,T,K+1);
        plot(time,sol(1,:))
        hold on
        plot(time, sol(2,:))
        legend('Beute','Rauber')
        xlabel('Zeit')
        ylabel('Bestand')
        title("R�uber-Beute Zeitverlauf mit expl. Heun-Verfahren, Zeitschritt: " + tau(k) + " seconds")
        hold off
    end 
    
    otherwise  
        error('Wrong input')
    
end 