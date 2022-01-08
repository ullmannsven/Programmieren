%%
% Abgabe des zweiten Programmierblatts von Sven Ullmann (3467077) und
% Thomas Stegmeyer (3401787) 
%% Aufgabe 1
%
% Die Funktionsweise von 1a) wird über die restlichen Aufgaben
% demonstriert. Die Funktion, um das Gitter zu bauen, sieht wie folgt aus
%
%%

type 'buildGitter.m'

%%
% Wir haben uns in der Implementierung dafür entschieden, die ausgeschnitten
% Ecken als NaN in der Gittermatrix Omega zu speichern. Damit ist eine
% Verallgemeinerung für Gebiete aus mehreren zusammengesetzten Würfel /
% Rechteck relativ einfach zu realisieren. Desweiteren haben wir bereits in
% der Initialiserung des Gitters eine Nummerierung aller Knoten, sowie eine
% Nummerierung aller Inneren Knoten vorgenommen. Vorallem letzteres ist
% hier leider nicht sehr effizient implementiert, aber es erfüllt seinen
% Zweck. Die Nummerierungen werden vorallem in der Aufgabe 2 folgenden
% assemble Routine sehr wichtig. 
%%
% Um das Gitter zu visualisieren haben wir folgenden Routine verwendet:
%%

type 'visualize_grid.m'

%%
% Damit sieht unser Gitter mit Gitterweite h = 1/4 wie folgt aus
%%

visualize_grid(1/4)

%% Aufgabe 2
% a) Um die Matrix A und den Vektor b für das anschließend zu lösenden LGS
% aufzubauen, haben wir uns folgenden Routine überlegt. Wir iterieren
% erneut über die Gesamte Gittermatrix, betrachten jetzt aber nur inneren
% Knoten. Dank der Vorarbeit in Aufgabe 1 ist das jetzt ein Kinderspiel.
% Von jedem inneren Knoten aus betrachten die für den jeweiligen
% Differenzenstern relevanten Knoten. Liegen diese ebenfalls im inneren, so
% wird ein Eintrag in Matrix A erzeugt. Sonst wird nichts (bzw. die 0) in
% die Matrix A eintragen. In den Vektor b tragen wir einfach die inneren
% den Funktionswert von f ausgewertet am jeweiligen innerne Knoten ein.
% Hier ist eine verallgemeinerung auf beliebige Randwerte auch möglich,
% allerdings ist das schon noch mit etwas Arbeit verbunden. 
%%

type 'assemble2.m' 

%%
% b) Um das entstanden LGS Au=b zu lösen, verwenden wir den einfachsten,
% aber laut Google sehr effizieten Weg des '\'. Da wir für die danach
% anstehende Visualisierung der Lösung auch wieder die Randknoten
% benötigen, fügen wir diese im Anschluss an richtiger Stelle wieder zu
% hinzu, sodass der resultierende Vektor u die Lösung auf allen Knoten
% widerspiegelt. 
%%

type 'solve.m'

%%
% c) Nun müssen wir nur noch die Lösung visualisieren: Wir speichern dafür
% den Vektor u wieder als Matrix, und zwar so das die jeweiligen
% Vektoreinträge mit der Nummerierung des Gitters übereinstimmt. Es ergibt
% sich folgendes: 
%%

type 'visualize.m' 

%%
% Die Methode ausgeführt wie in der Aufgabenstellung gefordert ergibt: 
%%

h_c = [1/(2^2), 1/(2^4),1/(2^8)];

for i = h_c
    Omega = buildGitter(i);
    [A,b,u_h] = assemble2(i,Omega);
    u = solve(A,b,u_h, Omega);
    visualize(u, Omega, i);
end 

%% 
% Um sich plausibel zu machen, das diese Ergebnisse in der Augennorm
% richtig aussehen hier einmal die Analytische Lösung geplottet auf einem recht fein
% aufgelösten Gitter über das gesamte (0,3)x(0,3) Gebiet. 

analytic_sol_func = @(x,y) sin(pi*x).*sin(2*pi*y);
[X,Y] = meshgrid(0:0.02:3,0:0.02:3);
figure;
surf(X,Y,analytic_sol_func(X,Y))
title('Analytic Solution')

%%
% Das sieht doch schonmal gut aus!


%% Aufgabe 3
% a) Jetzt ging es um die Fehler im Vergleich zur Analytischen Lösung, welche
% uns als 

%%

analytic_sol_func = @(x,y) sin(pi*x)*sin(2*pi*y);

%%
% angegeben gegeben wurde. Um den Fehler in der L_inf Norm zu messen haben
% wir folgende Routine entwickelt:
%%
type 'infty_error.m' 

%%
% b) Um die Konvergenzordnung 2 auch numerisch Nachzuweisen, haben wir die
% diese Fehler für einige Gitterweite in einem loglog Plot dargestellt.
% Dafür verwenden wir die Methode 
%%
type 'convergence.m' 

%% 
% Angewendet ergibt sich damit folgendes Bildchen: 
%%

T = convergence()

%%
% Quadratischer Fehlerabfall ist hier jetzt auch sehr schön zu erkennen.
% Interessanterweise ergibt sich für Gitterweite h=0.5 eine Lösung, welche
% auf allen ausgewerteten Gitterpunkten fast bis auf Maschinengenauigkeit
% übereinstimmt. Dies hat uns sehr überrascht: 

Omega_05 = buildGitter(0.5);
[A_05,b_05,u_05h] = assemble2(0.5,Omega_05);
u_05 = solve(A_05,b_05,u_05h,Omega_05);
error_05 = infty_error(u_05,Omega_05)
